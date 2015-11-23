define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocSectionView = require('cs!./toc/section')
  AddPopoverView = require('cs!./popovers/add/add')
  BookSearchResults = require('cs!models/book-search-results')
  template = require('hbs!./contents-template')
  require('less!./contents')

  cumulativeChapters = []
  oldNnumberChapters = (toc, depth=0) ->
    sectionNumber = 0
    skippedIntro = false
    isCcap = toc[0].isCcap?()?
    for item in toc
      isPage = not item.get('contents')?
      if isPage
        title = item.get('title')
        atTopLevel = depth == 0
        chapterNumber = cumulativeChapters[depth - 1]
        if not isCcap
          if depth > 0
            chapterNumber = cumulativeChapters.slice(0,depth).join('.') + '.'
          sectionNumber = cumulativeChapters[depth] ? 0
          item.set('chapter', "#{chapterNumber}#{sectionNumber}")
        else if not atTopLevel
          if sectionNumber > 0
            cumulativeChapters[depth] = sectionNumber
            item.set('chapter', "#{chapterNumber}.#{sectionNumber}")
          sectionNumber += 1
      else
        if cumulativeChapters[depth]?
          cumulativeChapters[depth] += 1
        else
          cumulativeChapters[depth] = 1
        contentsModels = item.get('contents')?.models
        if isCcap
          chapterNumber = cumulativeChapters[depth]
        else
          cumulativeChapters[depth + 1] = 0
          chapterNumber = cumulativeChapters.slice(0,depth+1).join('.')
        numberChapters(contentsModels, depth+1) if contentsModels?
        item.set('chapter', chapterNumber)

  basicNumbering = (nodes, parentNumber) ->
    for node, index in nodes
      chapterNumber = if parentNumber?
         "#{parentNumber}.#{index}"
       else
         index
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
          chapter.set('chapter', chapterNumber)
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

    regions:
      toc: '.toc'

    events:
      'dragstart .toc [draggable]': 'onDragStart'
      'dragend .toc [draggable]': 'onDragEnd'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable removeNode moveNode', @render)
      @listenTo(@model, 'change:contents', @processPages)
      @listenTo(@model, 'change:searchResults', @handleSearchResults)
      @listenTo(@model, 'change:currentPage', @loadHighlightedPage)

    onRender: () ->
      @$el.addClass('table-of-contents')
      @regions.toc.show new TocSectionView
        model: @model

      @regions.self.append new AddPopoverView
        model: @model
        owner: @$el.find('.add.btn')

    processPages: ->
      nodes = @model.get('contents')?.models
      if nodes?
        cumulativeChapters = []
        basicNumbering(nodes)
        if nodes[0].isCcap()
          continuousNumberChapters(nodes)
        @allPages = allPages(nodes)
        @render()

    expandContainers: (page, isExpanded, showingResults) ->
      visible = isExpanded or not showingResults
      for container in page.containers()
        container.set('expanded', isExpanded)
        container.set('visible', visible)

    handleSearchResults: ->
      expandContainers = @expandContainers
      pages = @allPages
      response = @model.get('searchResults')
      results = response?.items
      showingResults = results?.length > 0
      _.each pages, (page) ->
        page.unset('searchResult')
        page.unset('searchHtml')
        page.unset('searchTitle')
        page.set('visible', not showingResults)
        expandContainers(page, false, showingResults)
      if pages? and showingResults
        _.each results, (result) ->
          resultId = result.id.replace(/@.*/, '')
          snippet = result.headline
          _.some pages, (page) ->
            pageId = page.id.replace(/@.*/, '')
            matched = (resultId == pageId)
            if matched
              page.set('visible', matched)
              page.set('searchResult', snippet)
              expandContainers(page, true, true)
            return matched
      @loadHighlightedPage()
      @render()

    loadHighlightedPage: ->
      response = @model.get('searchResults')
      page = @model.asPage()
      if response and not page.get('searchHtml')
        searchTerm = @model.get('searchResults').query.search_term
        return if page.get('searchHtml')
        book = page.get('book')
        bookId = "#{book.get('id')}@#{book.get('version')}"
        pageId = "#{page.get('id')}@#{page.get('version')}"
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
