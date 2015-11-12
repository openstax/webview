define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  ContentsView = require('cs!../tabs/contents/contents')
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
      }

    initialize: (options) ->
      super()
      @hideProgress = options.hideProgress
      @mediaParent = options.mediaParent
      @tocIsOpen = false
      @.trigger('tocIsOpen', @tocIsOpen)
      @listenTo(@model, 'change:loaded change:currentPage removeNode moveNode add:contents', @render)

    events:
      'click .next': 'nextPage'
      'click .back': 'previousPage'
      'click .toggle.btn': 'toggleContents'
      'click .back-to-top > a': 'backToTop'

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

    backToTop: (e) ->
      e.preventDefault()
      @mediaParent.scrollToTop()

    onRender: ->
      if not @mediaParent?
        @mediaParent = @parent
      @regions.tocPanel?.show(new ContentsView({model: @model}))
      @updateToc()
