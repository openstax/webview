define (require) ->
  Backbone = require('backbone')

  return class RoleAcceptance extends Backbone.Model
    defaults:
      hasAcceptedLicense: 'false'
      loaded: 'false'
