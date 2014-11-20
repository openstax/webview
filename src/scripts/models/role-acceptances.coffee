define (require) ->
  Backbone = require('backbone')

  return class RoleAcceptance extends Backbone.Model
    defaults:
      title: ''
      licenseName: ''
      id: ''
      url: ''
      role: ''
      requester: ''
      assignmentDate: ''
      hasAccepted: ''
      hasAcceptedLicense: ''
