define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'hbs!templates/shared/featured-books'
  'less!styles/shared/featured-books'
], ($, _, Backbone, BaseView, template) ->

    return class FeaturedBooksView extends BaseView
      render: () ->
        @$el.html(template)

        return @
