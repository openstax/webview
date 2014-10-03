define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./attribution-template')
  require('less!./attribution')

  return class AttributionView extends FooterTabView
    template: template
    templateHelpers:
      id: () -> @model.getVersionedId() # Ensure the id has the version attached
