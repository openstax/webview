define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  searchResults = require('cs!models/search-results')
  BaseView = require('cs!helpers/backbone/views/base')
  AddPageSearchResultsView = require('cs!./results/results')
  template = require('hbs!./add-page-template')
  require('less!./add-page')
  require('bootstrapModal')

  return class AddPageModal extends BaseView
    template: template
    _hasSearchTitleError : false
    _hasAddPageError : false
    _checkedCounter: 0

    regions:
      results: '.add-page-search-results'

    events:
      'click .new-page': 'newPage'
      'click .search-pages': 'onSearch'
      'submit form': 'onSubmit'
      'change form': 'onChange'
      'keyup .page-title': 'onKeyUpSearch'
      'focus .page-title': 'onFocusSearch'
      'blur .page-title': 'onUnfocusSearch'
      'keypress .page-title': 'onEnter'

    onRender: () ->
      @$el.off('shown.bs.modal') # Prevent duplicating event listeners
      @$el.on 'shown.bs.modal', () => @$el.find('.page-title').focus()

    # Update the Search/Submit buttons to make the button that will
    # respond to 'Enter' to be styled as primary
    onFocusSearch: (e) ->
      @$el.find('.search-pages').addClass('btn-primary').removeClass('btn-plain')
      @$el.find('.btn-submit').addClass('btn-plain').removeClass('btn-primary')

    onUnfocusSearch: (e) ->
      @$el.find('.search-pages').addClass('btn-plain').removeClass('btn-primary')
      @$el.find('.btn-submit').addClass('btn-primary').removeClass('btn-plain')

    onKeyUpSearch: ()->
      @validate()

    onSearchTitleError: ()->
      @_hasSearchTitleError = true

      @$el.find('.page-title').parents('.form-group').addClass('has-warning')
      @$el.find('.search-pages').attr('disabled', true).addClass('btn-warning')

      @$el.find('.help-block').removeClass('hide')

    onSearchTitleUnerror: ()->
      @_hasSearchTitleError = false

      @$el.find('.page-title').parents('.form-group').removeClass('has-warning')
      @$el.find('.search-pages').attr('disabled', false).removeClass('btn-warning')

      @$el.find('.help-block').addClass('hide')

    onAddPageUnerror: ()->
      @_hasAddPageError = false

      @$el.find('.btn-submit').attr('disabled', false).removeClass('btn-warning')

    onAddPageError: ()->
      @_hasAddPageError = true

      @$el.find('.btn-submit').attr('disabled', true).addClass('btn-warning')

    # Intelligently determine if the user intended to search or add pages
    # when hitting the 'enter' key
    onEnter: (e) ->
      if e.keyCode is 13
        e.preventDefault()
        e.stopPropagation()

        $input = @$el.find('.page-title')

        if $input.is(':focus')
          @search($input.val())
        else
          @$el.find('form').submit()

    onChange: (e) ->
      $target = $(e.target)

      # Use a counter to determine how many check boxes are selected
      # rather than looping through and counting them every time,
      # since there could be a huge number of check boxes.
      if $target.attr('type') is 'checkbox'
        if $target.is(':checked')
          @_checkedCounter++
        else
          @_checkedCounter--

      if @_checkedCounter is 0
        @$el.find('.btn-submit').text('Create New Page')
      else if @_checkedCounter is 1
        @$el.find('.btn-submit').text('Add Selected Page')
      else
        @$el.find('.btn-submit').text('Add Selected Pages')

      @validate()

      if not @_hasAddPageError
        @onSearchTitleUnerror()

    onSearch: (e) ->
      title = @$el.find('.page-title').val()
      @search(title)

    search: (title) ->
      if @validateSearch(title)
        @_checkedCounter = 0
        title = encodeURIComponent(title)
        results = searchResults.config().load({query: "?q=title:%22#{title}%22%20type:page"})
        @regions.results.show(new AddPageSearchResultsView({model: results}))

    validate: (title)->
      @validateSearch(title)
      @validateAddPage()

      not (@_hasSearchTitleError and @_hasAddPageError)

    validateSearch: (title)->
      if @isSearchTitleValid(title)
        if @_hasSearchTitleError
          @onSearchTitleUnerror()
      else if not @_hasSearchTitleError
        @onSearchTitleError()

      not @_hasSearchTitleError

    validateAddPage: ()->
      if @canAddNewPage()
        if @_hasAddPageError
          @onAddPageUnerror()
      else if not @_hasAddPageError
        @onAddPageError()

      not @_hasAddPageError

    isSearchTitleValid: (title)->

      title = if title then title else @$el.find('.page-title').val()
      title.trim().length > 0

    canAddNewPage: ()->
      (@_checkedCounter > 0) or @isSearchTitleValid()

    updateUrl: () ->
      # Update the url bar path
      href = linksHelper.getPath 'contents',
        model: @model
        page: @model.getPageNumber()
      router.navigate(href, {trigger: false, analytics: true})

    onSubmit: (e) ->
      e.preventDefault()

      data = $(e.originalEvent.target).serializeArray()

      if not @validate(_.find(data, {name: 'title'}).value)
        return

      @$el.modal('hide')

      if data.length is 1
        @newPage(data[0].value)
      else
        _.each data, (input) =>
          if input.name isnt 'title'
            @model.add({id: input.name, title: input.value})
            @model.setPage(input.name)
            @updateUrl()

      $('.modal-backdrop').remove() # HACK: Ensure bootstrap modal backdrop is removed

    newPage: (title) ->
      options =
        success: (model) =>
          @model.setPage(model)
          @updateUrl()

      @model.create({title: title}, options)
