define (require) ->
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
      'click .search': 'onSearch'
      'submit': 'onSubmit'

    onSearch: (e) ->
      $modal = @$el.children('#add-page-modal')
      title = encodeURIComponent($modal.find('.page-title').val())
      results = searchResults.load("?q=title:#{title}%20type:page")

      @regions.results.show(new AddPageSearchResultsView({model: results}))

    onSubmit: (e) ->
      e.preventDefault()
      console.log 'FIX: Add selected pages'
      
      console.log e

    newPage: () ->
      $modal = @$el.children('#add-page-modal')
      title = $modal.find('.page-title').val()

      @model.newPage(title)

      $('.modal-backdrop').remove() # Hack to ensure bootstrap modal backdrop is removed
