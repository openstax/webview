define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocSectionView = require('cs!./toc/section')
  AddPopoverView = require('cs!./popovers/add/add')
  BookSearchResults = require('cs!models/book-search-results')
  template = require('hbs!./contents-template')
  require('less!./contents')

  basicNumbering = (nodes, parentNumber) ->
    for node, index in nodes
      chapterNumber =
        if parentNumber?
          "#{parentNumber}.#{index+1}"
        else
          index+1
      node.set('chapter', chapterNumber)
      if node.isSection()
        childNodes = node.get('contents')?.models
        basicNumbering(childNodes, chapterNumber) if childNodes?

  continuousNumberChapters = (nodes) ->
    pages = allPages(nodes)
    previousChapter = ''
    chapterNumber = 0
    pageNumber = 0
    for page in pages
      chapter = page.get('_parent')
      if chapter? and chapter.isSection()
        if chapter == previousChapter
          pageNumber += 1
        else
          chapterNumber += 1
          pageNumber = 0
          previousChapter = chapter
          # Chapters inside units get labeled "Chapter ##"
          if chapter.get('book') is chapter.get('_parent')
            chapter.set('chapter', chapterNumber)
          else
            chapter.set('chapter', "Chapter #{chapterNumber}.")
          page.unset('chapter', chapterNumber)
        if pageNumber > 0
          page.set('chapter', "#{chapterNumber}.#{pageNumber}")


  allPages = (nodes, collection=[]) ->
    _.each nodes, (node) ->
      if node.isSection()
        children = node.get('contents').models
        allPages(children, collection)
      else
        collection.push(node)
    collection

  return class ContentsView extends BaseView
    template: template
    templateHelpers:
      resultCountText: () ->
        hits = @model?.get('searchResults')?.total
        return unless hits?
        if hits is 0
          "No matching results were found."
        else
          s = if hits is 1 then '' else 's'
          "#{hits} page#{s} matched"
      resultCount: () ->
        @model?.get('searchResults')?.total
      isBook: () ->
        if @model["attributes"]["page"]
          "book"
        else
          null
      booksIn: () ->
        @model?.get('booksContainingPage')
      numBooks:() ->
        @model?.get('booksContainingPage')?.length
      pageId:() ->
        (window.location.href.split '/')[4]

    regions:
      toc: '.toc'

    events:
      'dragstart .toc [draggable]': 'onDragStart'
      'dragend .toc [draggable]': 'onDragEnd'
      'click .clear-results': 'clearSearchResults'

    initialize: () ->
      super()
      @listenTo(@model, 'removeNode addNode moveNode', @processPages)
      @listenTo(@model, 'change:editable change:currentPage addNode removeNode moveNode', _.debounce(@render, 250))
      @listenTo(@model, 'change:contents add:contents remove:contents', _.debounce(@processPages, 250))
      @listenTo(@model, 'change:searchResults', @handleSearchResults)
      @listenTo(@model, 'change:currentPage', @loadHighlightedPage)
      @listenTo(@model, 'change:booksContainingPage', @handleBooksContainingPage)
      @scrollPosition = 0

    onRender: () ->
      @$el.addClass('table-of-contents')
      @regions.toc.show new TocSectionView
        model: @model

      @regions.self.append new AddPopoverView
        model: @model
        owner: @$el.find('.add.btn')

    processPages: ->
      return unless @model
      @model.cachedPages = undefined
      nodes = @model.get('contents')?.models
      if nodes?.length
        isCcap = nodes[0].isCcap()
        isCollated = nodes[0].isCollated()
        unless isCollated
          if isCcap
            sections = nodes.filter((node) -> node.isSection())
            basicNumbering(sections)
            continuousNumberChapters(sections)
          else
            basicNumbering(nodes)
        @allPages = allPages(nodes)

    expandContainers: (page, isExpanded, handlingResults) ->
      visible = isExpanded or not handlingResults
      for container in page.containers()
        container.set('expanded', isExpanded)
        container.set('visible', visible)

    handleSearchResults: ->
      response = @model.get('searchResults')
      handlingResults = response?
      expandContainers = @expandContainers
      pages = @allPages
      _.each pages, (page) ->
        #! Need to refactor this into a single object
        page.unset('searchResult')
        page.unset('searchHtml')
        page.unset('searchTitle')
        page.unset('searchResultCount')
        page.set('visible', not handlingResults)
        expandContainers(page, false, handlingResults)
      if handlingResults
        results = response.items ? []
        if pages?
          _.each results, (result) ->
            resultId = result.id.replace(/@.*/, '')
            snippet = result.snippet ? result.headline # backward-compatible
            matchCount = result.matches
            _.some pages, (page) ->
              pageId = page.id.replace(/@.*/, '')
              matched = (resultId == pageId)
              if matched
                page.set('visible', matched)
                page.set('searchResult', snippet)
                page.set('searchResultCount', matchCount)
                expandContainers(page, true, true)
              return matched
        @loadHighlightedPage()
      @render()

    clearSearchResults: (event) ->
      event.preventDefault()
      @model.unset('searchResults')

    loadHighlightedPage: ->
      response = @model.get('searchResults')
      page = @model.asPage()
      if response and not page.get('searchHtml')
        searchTerm = @model.get('searchResults').query.search_term
        return if page.get('searchHtml')
        book = page.get('book')
        bookId = "#{book.get('id')}@#{book.get('version')}"
        pageId = "#{page.get('id')}"
        pageVersion = page.get('version')
        pageId += "@#{pageVersion}" if pageVersion?

        BookSearchResults.fetch(
          bookId: "#{bookId}:#{pageId}"
          query: response.query.search_term
        ).done((data) ->
          return unless data.results.items.length
          html = data.results.items[0].html

          # Adapted from models/contents/node.coffee; make a parseBody utility?
          $body = $('<div>' + html.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
          $title = $body.children('[data-type=document-title]').eq(0).remove()
          $body.children('[data-type=abstract]').eq(0).remove()
          html = $body.html()

          page.set('searchHtml', html)
          page.set('searchTitle', $title.html())
        )

    onDragStart: (e) ->
      # Prevent children from interfering with drag events
      @$el.find('[draggable]').children().css('pointer-events', 'none')

    onDragEnd: (e) ->
      # Restore pointer events
      @$el.find('[draggable]').children().css('pointer-events', 'auto')

      # Reset styling for all draggable elements
      e.currentTarget.className = ''
      @model.trigger('moveNode')

    handleBooksContainingPage: ->
      @render()
