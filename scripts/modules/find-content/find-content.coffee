define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!./find-content-template'
  'less!./find-content'
], ($, _, Backbone, BaseView, template) ->

    return class FindContentView extends BaseView
      template: template()

      render: () ->
        @$el.html(@template)

        return @
