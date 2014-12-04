define (require) ->
  Backbone = require('backbone')

  return class RoleAcceptance extends Backbone.Model
    id = window.location.pathname.match(/\/[^\/]+$/)
    defaults:
      linkToContent: "#{location.protocol}//#{location.host}/contents#{id}@draft"
      hasAcceptedLicense: false
