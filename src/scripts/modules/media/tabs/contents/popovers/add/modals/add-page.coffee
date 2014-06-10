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
  require('bootstrapTransition')
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
      'focus .page-title': 'onFocusSearch'
      'blur .page-title': 'onUnfocusSearch'
      'keypress .page-title': 'onEnter'

    # Update the Search/Submit buttons to make the button that will
    # respond to 'Enter' to be styled as primary
    onFocusSearch: (e) ->
      @$el.find('.search-pages').addClass('btn-primary').removeClass('btn-plain')
      @$el.find('.btn-submit').addClass('btn-plain').removeClass('btn-primary')

    onUnfocusSearch: (e) ->
      @$el.find('.search-pages').addClass('btn-plain').removeClass('btn-primary')
      @$el.find('.btn-submit').addClass('btn-primary').removeClass('btn-plain')

    # Intelligently determine if the user intended to search or add pages
    # when hitting the 'enter' key
    onEnter: (e) ->
      if e.keyCode is 13
        e.preventDefault()
        e.stopPropagation()

        $modal = @$el.children('#add-page-modal')
        $input = $modal.find('.page-title')

        if $input.is(':focus')
          @search($input.val())
        else
          $modal.find('form').submit()

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

    onSearch: (e) ->
      $modal = @$el.children('#add-page-modal')
      title = encodeURIComponent($modal.find('.page-title').val())
      @search(title)

    search: (title) ->
      @_checkedCounter = 0
      results = searchResults.load({query: "?q=title:#{title}%20type:page"})
      @regions.results.show(new AddPageSearchResultsView({model: results}))

    updateUrl: () ->
      # Update the url bar path
      href = linksHelper.getPath 'contents',
        model: @model
        page: @model.getPageNumber()
      router.navigate(href, {trigger: false, analytics: true})

    onSubmit: (e) ->
      e.preventDefault()

      data = $(e.originalEvent.target).serializeArray()

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
          @model.setPage(@model.get('contents').indexOf(model)+1)
          @updateUrl()

      @model.create({title: title}, options)
