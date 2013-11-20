define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  return class MetadataView extends FooterTabView
    template: template
