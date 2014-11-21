define (require) ->
  Backbone = require('backbone')

  return class RoleAcceptance extends Backbone.Model
    defaults:
      loaded: 'false'
      hasAcceptedLicense: 'false'
