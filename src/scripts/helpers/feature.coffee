define (require) ->
  _ = require('underscore')
  settings = require('settings')

  return (base, featureInitializers) ->
    module = base
    _.each(settings.features, (feature) ->
      module = featureInitializers[feature](module) if featureInitializers[feature]?
    )
    return module
