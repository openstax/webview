define (require) ->
  FooterTabView = require('cs!../inherits/tab/tab')
  template = require('hbs!./attribution-template')
  require('less!./attribution')

  return class AttributionView extends FooterTabView
    template: template
    templateHelpers: () ->
      model = super()
      model.id = @model.getVersionedId() # Ensure the id has the version attached
      return model
