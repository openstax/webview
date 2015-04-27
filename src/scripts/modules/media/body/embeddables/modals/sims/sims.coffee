define (require) ->
  EditableView = require('cs!helpers/backbone/views/editable')
  template = require('hbs!./sims-template')
  require('less!./sims')

  return class SimsView extends EditableView
    template: template

    initialize: () ->
      @listenTo(@model, 'change:simUrl change:simTitle', @render)
