define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocSectionView = require('cs!./toc/section')
  AddPopoverView = require('cs!./popovers/add/add')
  BookSearchResults = require('cs!models/book-search-results')
  template = require('hbs!./contents-template')
  require('less!./contents')

  cumulativeChapters = []
  numberChapters = (toc, depth=0) ->
    sectionNumber = 0
    skippedIntro = false
    for item in toc
      isSection = not item.get('contents')?
      isCcap = (item.get('book')?.get('printStyle') ? '').match(/^ccap-/)?
      if isSection
        title = item.get('title')
        atTopLevel = depth == 0
        chapterNumber = cumulativeChapters[depth - 1]
        if not isCcap
          chapterNumber = cumulativeChapters.slice(0,depth).join('.')
          sectionNumber = cumulativeChapters[depth] ? 0
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

  allPages = (nodes, collection) ->
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
        numberChapters(nodes)
        @allPages = []
        allPages(nodes, @allPages)
        @render()

    expandContainers: (page, isExpanded, showingResults) ->
      container = page.get('_parent')
      visible = isExpanded or not showingResults
      while container.isSection()
        container.set('expanded', isExpanded)
        container.set('visible', visible)
        container = container.get('_parent')

    handleSearchResults: ->
      expandContainers = @expandContainers
      pages = @allPages
      response = @model.get('searchResults')
      results = response?.items
      showingResults = results?.length > 0
      _.each pages, (page) ->
        page.unset('searchResult')
        page.unset('searchHtml')
        page.set('visible', not showingResults)
        expandContainers(page, false, showingResults)
      if pages? and showingResults
        _.each results, (result) ->
          resultId = result.id.replace(/@.*/, '')
          snippet = result.headline.
          replace(/<q-match>/g, '<span class="q-match">').
          replace(/<\/q-match>/g, '</span>')
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
          bookId: "#{bookId}/#{pageId}"
          query: response.query.search_term
        ).done((data) ->
          return unless data.results.items.length
          html = data.results.items[0].html.replace(/<q-match>/g, '<span class="q-match">').
          replace(/<\/q-match>/g, '</span class="q-match">')
          $htmlNodes = $(html)
          metaIndex = 0
          # Heuristic: The actual content starts with a paragraph that has an id
          ++metaIndex until $htmlNodes[metaIndex]?.id or metaIndex > $htmlNodes.length
          $htmlNodes = $htmlNodes.slice(metaIndex)
          html = $('<div>').append($htmlNodes).html()
          page.set('searchHtml', html)
        )

    onDragStart: (e) ->
      # Prevent children from interfering with drag events
      @$el.find('[draggable]').children().css('pointer-events', 'none')

    onDragEnd: (e) ->
      # Restore pointer events
      @$el.find('[draggable]').children().css('pointer-events', 'auto')

      # Reset styling for all draggable elements
      e.currentTarget.className = ''
