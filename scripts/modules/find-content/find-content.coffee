define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/base'
  'hbs!templates/modules/find-content/find-content'
  'less!./find-content'
], ($, _, Backbone, BaseView, template) ->

    return class FindContentView extends BaseView
      template: template()

      render: () ->
        @$el.html(@template)

        return @
