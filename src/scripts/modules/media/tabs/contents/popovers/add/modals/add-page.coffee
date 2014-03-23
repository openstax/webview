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

    regions:
      results: '.add-page-search-results'

    events:
      'click .new-page': 'newPage'
      'click .search-pages': 'onSearch'
      'submit form': 'onSubmit'
      'keypress .page-title': 'onEnter'

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

    onSearch: (e) ->
      $modal = @$el.children('#add-page-modal')
      title = encodeURIComponent($modal.find('.page-title').val())
      @search(title)

    search: (title) ->
      results = searchResults.load("?q=title:#{title}%20type:page")
      @regions.results.show(new AddPageSearchResultsView({model: results}))

    onSubmit: (e) ->
      e.preventDefault()

      data = $(e.originalEvent.target).serializeArray()

      _.each data, (input) =>
        if input.name isnt 'title'
          @model.add({id: input.name, title: input.value})

      $('.modal-backdrop').remove() # HACK: Ensure bootstrap modal backdrop is removed

    newPage: () ->
      $modal = @$el.children('#add-page-modal')
      title = $modal.find('.page-title').val()

      @model.newPage(title)

      $('.modal-backdrop').remove() # HACK: Ensure bootstrap modal backdrop is removed
