define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  settings = require('settings')
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

    initialize: () ->
      super()
      @renderValidations = @initializeValidations()

    onRender: () ->
      @$el.off('shown.bs.modal') # Prevent duplicating event listeners
      @$el.on 'shown.bs.modal', () => @$el.find('.page-title').focus()
      @$el.on 'hide.bs.modal', () => @cancelSearch()

      @renderValidations()

    # Update the Search/Submit buttons to make the button that will
    # respond to 'Enter' to be styled as primary
    onFocusSearch: (e) ->
      @$el.find('.search-pages').addClass('btn-primary').removeClass('btn-plain')
      @$el.find('.btn-submit').addClass('btn-plain').removeClass('btn-primary')

    onUnfocusSearch: (e) ->
      @$el.find('.search-pages').addClass('btn-plain').removeClass('btn-primary')
      @$el.find('.btn-submit').addClass('btn-primary').removeClass('btn-plain')

    onKeyUpSearch: (e) ->
      if @validations.searchTitle.hasError
        @validations.searchTitle.validate()

      if @validations.addPage.hasError
        @validations.addPage.validate()

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

      if @validations.addPage.hasError
        @validations.addPage.validate()

      if @validations.searchTitle.hasError
        @validations.searchTitle.hide()

    onSearch: (e) ->
      title = @$el.find('.page-title').val()
      @search(title)

    search: (title) ->
      if @validations.searchTitle.validate(title)
        title = encodeURIComponent(title)
        @_checkedCounter = 0
        @results = searchResults.config().load({query: "?q=title:%22#{title}%22%20type:page"})
        @regions.results.show(new AddPageSearchResultsView({model: @results}))

    cancelSearch: () ->
      if @results?.get('promise')
        @results.get('promise').abort()

      @clearSearch()

    clearSearch: () ->
      @regions.results.empty()
      @$el.find('.page-title').val('')

      @validations.addPage.hide()
      @validations.searchTitle.hide()

    initializeValidations: () ->
      @validations =
        addPage:
          hasError: false
          check: @_canAddPage
          message: () =>
            message = 'Please '
            message += 'choose an existing page from the results to add or ' if @results?.get('results')?.items?.length
            message +='enter a title to add a new page.'
            message
        searchTitle:
          hasError: false
          check: @_isSearchTitleValid
          message: () =>
            'Please enter a title to search for existing pages to add to this book.'

      # common validation methods
      hide = () ->
        @hasError = false
        @$formGroupEl.removeClass('has-error')
        @$buttonEl.attr('disabled', false)
        @$alertEl.addClass('hidden')

      show = () ->
        @hasError = true
        @$formGroupEl.addClass('has-error')
        @$buttonEl.attr('disabled', true)
        @$alertEl.removeClass('hidden').children('.message').text(@message())

      validate = (title...) ->
        if @check.apply(arguments)
          if @hasError
            @hide()
        else if not @hasError
          @show()

        not @hasError

      @validations.searchTitle.hide = hide
      @validations.addPage.hide = hide

      @validations.searchTitle.show = show
      @validations.addPage.show = show

      @validations.searchTitle.validate = validate
      @validations.addPage.validate = validate

      # Returns function for rendering validations.
      # Finds elements that will be manipulated during validations
      () ->
        @validations.searchTitle.$formGroupEl = @$el.find('.page-title').parents('.form-group')
        @validations.addPage.$formGroupEl = @validations.searchTitle.$formGroupEl

        @validations.searchTitle.$alertEl = @$el.find('.alert')
        @validations.addPage.$alertEl = @validations.searchTitle.$alertEl

        @validations.searchTitle.$buttonEl = @validations.searchTitle.$formGroupEl.find('.search-pages')
        @validations.addPage.$buttonEl = @$el.find('.modal-footer').find('.btn-submit')

    _isSearchTitleValid: (title) =>
      title = if title then title else @$el.find('.page-title').val()
      title.trim().length > 0

    _canAddPage: () =>
      (@_checkedCounter > 0) or @validations.searchTitle.check()

    updateUrl: () ->
      # Update the url bar path
      href = linksHelper.getPath 'contents',
        model: @model
        page: @model.getPageNumber()
      router.navigate(href, {trigger: false, analytics: true})

    onSubmit: (e) ->
      e.preventDefault()

      data = $(e.originalEvent.target).serializeArray()

      if @validations.searchTitle.hasError
        @validations.searchTitle.hide()

      if not @validations.addPage.validate()
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
      license = @model.get('license')
      options =
        success: (model) =>
          @model.setPage(model)
          @updateUrl()

      if @model.get('license').code isnt settings.defaultLicense.code
        license = { 'code': license.code, 'name': license.name, 'url': license.url, 'version': license.version }

      @model.create({title: title, license: license}, options)
