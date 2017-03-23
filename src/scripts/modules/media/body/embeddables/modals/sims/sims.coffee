define (require) ->
  ContentView = require('cs!helpers/backbone/views/content')
  template = require('hbs!./sims-template')
  require('less!./sims')

  return class SimsView extends ContentView
    template: template

    initialize: () ->
      @listenTo(@model, 'change:simUrl change:simTitle', @render)
