define (require) ->
  settings = require('settings')
  _ = require('underscore')

  hasFeature = (featureName) ->
    _.contains(settings.features, featureName)

  return (featureName, enabledModule, disabledModule) ->
    module = if hasFeature(featureName) then enabledModule else disabledModule
    return module
