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
          $('head').append("<link rel=\"next\" href=\"#{location.host}#{next}\" />") if next

      $('link[rel="prev"]').remove()
      if page isnt previousPage
        back = linksHelper.getPath('contents', {model: @model, page: previousPage})
        if back isnt undefined
          $('head').append("<link rel=\"prev\" href=\"#{location.host}#{back}\" />") if back

      return {
        _hideProgress: @hideProgress
        book: @model.isBook()
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
      'click .toggle.btn': 'toggleContents'
      'click .back-to-top > a': 'backToTop'
      'keydown .searchbar input': 'handleSearchInput'
      'click .searchbar > .fa-close': 'clearSearch'

    toggleContents: (e) ->
      @tocIsOpen = not @tocIsOpen
      @.trigger('tocIsOpen', @tocIsOpen)
      @updateToc()

    updateToc: ->
      button = @$el.find('.toggle.btn')
      if (@tocIsOpen)
        button.addClass('open')
      else
        button.removeClass('open')

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

    changePage: (e) ->
      # Don't intercept cmd/ctrl-clicks intended to open a link in a new tab
      return if e.metaKey or e.which isnt 1

      e.preventDefault()
      e.stopPropagation()
      href = $(e.currentTarget).attr('href')
      router.navigate href, {trigger: false}, () => @mediaParent.trackAnalytics()
      @mediaParent.scrollToTop()

    closeContentsOnSmallScreen: ->
      if window.innerWidth < 640
        if @tocIsOpen
          @toggleContents()
        @mediaParent.scrollToTop()

    backToTop: (e) ->
      e.preventDefault()
      @mediaParent.scrollToTop()

    clearSearch: ->
      @searchTerm = ''
      @$el.find('.searchbar input').val(@searchTerm)
      @model.unset('searchResults')
      @$el.find('.searchbar > .fa').
      removeClass('fa-close').
      addClass('fa-search')

    enableClearSearch: ->
      @$el.find('.searchbar > .fa').
      removeClass('fa-search').
      addClass('fa-close')

    handleSearchInput: (event) ->
      if (event.keyCode == 13 and event.target.value?)
        @searchTerm = event.target.value
        event.preventDefault()
        if @searchTerm == ''
          @clearSearch()
          return
        options = {
          bookId: "#{@model.get('id')}@#{@model.get('version')}",
          query: @searchTerm
        }
        BookSearchResults.fetch(options).done((data) =>
          if not @tocIsOpen
            @toggleContents()
          @model.set('searchResults', data.results)
          @enableClearSearch()
        ).fail((err) ->
          console.error("Search failed:", err)
        )

    onRender: ->
      if not @mediaParent?
        @mediaParent = @parent
      @regions.tocPanel?.show(new ContentsView({model: @model}))
      @enableClearSearch() if @model.get('searchResults')?
      @updateToc()
