define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!./featured-books-template'
  'less!./featured-books'
], ($, _, Backbone, BaseView, template) ->

    return class FeaturedBooksView extends BaseView
      template: template()

      render: () ->
        @$el.html(@template)

        return @
