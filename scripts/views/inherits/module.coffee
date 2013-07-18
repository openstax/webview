define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
], ($, _, Backbone, BaseView) ->

  return class ModuleView extends BaseView
    initialize: () ->
      super()
      
      # add a content region to add views to and automatically insert them