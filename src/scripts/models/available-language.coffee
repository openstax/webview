define (require) ->
  Backbone = require('backbone')

  return class AvailableLanguage extends Backbone.Model
    defaults:
      id: ''
      native: ''
