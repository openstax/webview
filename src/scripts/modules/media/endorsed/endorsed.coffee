define [
  'cs!helpers/backbone/views/base'
  'hbs!./endorsed-template'
  'less!./endorsed'
], (BaseView, template) ->

  return class EndorsedView extends BaseView
    template: template()
