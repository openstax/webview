define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'cs!collections/library'
  'hbs!./featured-books-template'
  'less!./featured-books'
], ($, _, Backbone, BaseView, library, template) ->

    return class FeaturedBooksView extends BaseView
      initialize: () ->
        @listenTo(library, 'reset', @render)

      render: () ->
        @template = template({books: library.toJSON()})
        super()
