define (require) ->
  $ = require('jquery')
  _ = require('underscore')
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
      results = searchResults.load("?q=title:#{title}%20type:page")
      @regions.results.show(new AddPageSearchResultsView({model: results}))

    onSubmit: (e) ->
      e.preventDefault()

      data = $(e.originalEvent.target).serializeArray()
      models = []

      if data.length is 1
        @newPage(data[0].value)
      else
        _.each data, (input) =>
          if input.name isnt 'title'
            models.push
              derivedFrom: input.name

        # FIX: Currently always just derive a page from published content
        if models.length
          @model.create(models)

      $('.modal-backdrop').remove() # HACK: Ensure bootstrap modal backdrop is removed

    newPage: (title) ->
      @model.create({title: title})
