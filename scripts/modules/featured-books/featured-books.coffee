define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!templates/modules/featured-books/featured-books'
  'less!./featured-books'
], ($, _, Backbone, BaseView, template) ->

    return class FeaturedBooksView extends BaseView
      template: template()

      render: () ->
        @$el.html(@template)

        return @
