define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'hbs!templates/shared/find-content'
  'less!styles/shared/find-content'
], ($, _, Backbone, BaseView, template) ->

    return class FindContentView extends BaseView
      template: template()
      render: () ->
        @$el.html(@template)

        return @
