define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  ContentsView = require('cs!../tabs/contents/contents')
  BookSearchResults = require('cs!models/book-search-results')
  template = require('hbs!./nav-template')
  require('less!./nav')

  return class MediaNavView extends BaseView
    template: template
    templateHelpers: () ->
      page = @model.getPageNumber()
      nextPage = @model.getNextPageNumber()
      previousPage = @model.getPreviousPageNumber()

      $('link[rel="next"]').remove()
      if page isnt nextPage
        next = linksHelper.getPath('contents', {model: @model, page: nextPage})
        if next isnt undefined
          urlScheme = window.location.protocol+"//"
          $('head').append("<link rel=\"next\" href=\"#{location.host}#{next}\" />") if next
          $('link[rel="prerender"]').remove()
          $('head').append("<link rel=\"prerender\" href=\"#{urlScheme}#{location.host}#{next}\" />") if next

      $('link[rel="prev"]').remove()
      if page isnt previousPage
        back = linksHelper.getPath('contents', {model: @model, page: previousPage})
        if back isnt undefined
          $('head').append("<link rel=\"prev\" href=\"#{location.host}#{back}\" />") if back

      return {
        _hideProgress: @hideProgress
        book: @model.isBook()
        isPage: @model.isPage()
        next: next
        back: back
        pages: if @model.get('loaded') then @model.getTotalPages() else 0
        page: if @model.get('loaded') then @model.getPageNumber() else 0
        searchTerm: @searchTerm
      }

    initialize: (options) ->
      super()
      @hideProgress = options.hideProgress
      @mediaParent = options.mediaParent
      @tocIsOpen = false
      @.trigger('tocIsOpen', @tocIsOpen)
      @listenTo(@model, 'change:loaded change:currentPage removeNode moveNode add:contents', @render)
      @listenTo(@model, 'change:currentPage', @closeContentsOnSmallScreen)

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'
      'keydown .book-nav a.nav': 'changePageWithKeyboard'
      'click .toggle.btn': 'toggleContents'
      'click .back-to-top > a': 'backToTop'
      'keydown .searchbar input': 'handleSearchInput'
      'click .searchbar > .clear-search': 'clearSearch'
      'click .searchbar > .fa-search': 'handleSearch'

    closeAllContainers: (nodes = @model.get('contents')?.models) =>
      if nodes
        for node in nodes
          if node.isSection()
            node.set('expanded', false)
            @closeAllContainers(node.get('contents').models)

    toggleContents: (e) ->
      # This component is used in the ToC as well as the intro page.
      # Having the aria attributes causes confusion because there are 2 `<nav>` elements on the page
      # See #1975
      firstElementInSidebarToc = null
      if $('.toc')[0]
        firstElementInSidebarToc = $('.toc')[0].querySelector('.name-wrapper a, .section-wrapper')
      @tocIsOpen = not @tocIsOpen
      @.trigger('tocIsOpen', @tocIsOpen)
      if @tocIsOpen
        @closeAllContainers() unless @model.get('searchResults')
        for container in @model.get('currentPage')?.containers() ? []
          container.set('expanded', true)
        if firstElementInSidebarToc
          firstElementInSidebarToc.focus()
      @updateToc()

    toggleBooksList: (e) ->
      @tocIsOpen = not @tocIsOpen
      @.trigger('tocIsOpen', @tocIsOpen)
      if @tocIsOpen
        @closeAllContainers() unless @model.get('searchResults')
        for container in @model.get('currentPage')?.containers() ? []
          container.set('expanded', true)
      @updateToc()


    updateToc: ->
      button = @$el.find('.toggle.btn')
      indicator = button.find('.open-indicator')
      if (@tocIsOpen)
        button.addClass('open')
        indicator.removeClass('fa-plus')
        indicator.addClass('fa-minus')
      else
        button.removeClass('open')
        indicator.addClass('fa-plus')
        indicator.removeClass('fa-minus')

    nextPage: (e) ->
      nextPage = @model.getNextPageNumber()
      # Show the next page if there is one
      @changePage(e)
      @model.setPage(nextPage)

    previousPage: (e) ->
      previousPage = @model.getPreviousPageNumber()
      # Show the previous page if there is one
      @changePage(e)
      @model.setPage(previousPage)
    
    changePageWithKeyboard: (e) ->
      if e.keyCode is 13 or e.keyCode is 32
        window.pageWasChangedWithKeyboard = true
        e.target.click()

    changePage: (e) ->
      # Don't intercept cmd/ctrl-clicks intended to open a link in a new tab
      return if e.metaKey or e.which isnt 1

      e.preventDefault()
      e.stopPropagation()
      href = $(e.currentTarget).attr('href')
      # this sends the page without a version number (which causes analytics to fire).
      # It fires twice because @mediaParent.trackAnalytics() also sends an event.
      router.navigate href, {trigger: false}, () => @mediaParent.trackAnalytics()

    closeContentsOnSmallScreen: ->
      if window.innerWidth < 640
        if @tocIsOpen
          @toggleContents()
        $(window).scrollTop(0)

    backToTop: (e) ->
      e.preventDefault()
      $(window).scrollTop(0)

    clearSearch: ->
      @searchTerm = ''
      @$el.find('.searchbar input').val(@searchTerm)
      @model.unset('searchResults')
      @$el.find('.searchbar > .fa').
      removeClass('fa-times-circle clear-search').
      addClass('fa-search')

    enableClearSearch: ->
      @$el.find('.searchbar > .fa').
      removeClass('fa-spinner fa-spin load-search').
      addClass('fa-times-circle clear-search')

    enableLoadSearch: ->
      @$el.find('.searchbar > .fa').
      removeClass('fa-search').
      addClass('fa-spinner fa-spin load-search')

    enableSearch: ->
      @$el.find('.searchbar > .fa').
      removeClass('fa-spinner fa-spin load-search').
      addClass('fa-search')

    handleSearch: ->
      @searchTerm = @$el.find('.searchbar input').val()
      if @searchTerm == ''
        @clearSearch()
        return
      options = {
        bookId: "#{@model.get('id')}@#{@model.get('version')}",
        query: @searchTerm
      }
      # before the search has loaded
      @enableLoadSearch()
      # after the search has completed
      BookSearchResults.fetch(options).done((data) =>
        if not @tocIsOpen
          @toggleContents()
        @model.set('searchResults', data.results)
        @enableSearch()
      ).fail((err) ->
        console.error("Search failed:", err)
      )
      
    handleSearchInput: (event) ->
      if event.keyCode == 13
        event.preventDefault()
        @handleSearch()

    onRender: ->
      if not @mediaParent?
        @mediaParent = @parent
      @regions.tocPanel?.show(new ContentsView({model: @model}))
      @enableClearSearch() if @model.get('searchResults')?
      @updateToc()
      if @model.isPage()
        @toggleBooksList()
        @closeContentsOnSmallScreen()
