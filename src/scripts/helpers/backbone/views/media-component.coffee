define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  BaseView = require('cs!helpers/backbone/views/base')

  return class MediaComponentView extends BaseView
    getProperty: (property) -> @getModel()?.get(property)

    setProperty: (property, value) -> @getModel().set(property, value)

    getModel: () ->
      if @media is 'page'
        return @model?.asPage?()
      
      return @model
