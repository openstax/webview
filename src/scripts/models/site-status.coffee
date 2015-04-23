define (require) ->
  Backbone = require('backbone')

  return class SiteStatus extends Backbone.Model
    defaults:
      message: ''
      starts: ''
      ends: ''
      name: ''
      show: true
