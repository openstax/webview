define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  template = require('hbs!./error-template')
  require('less!./error')

  class InnerView extends BaseView
    template: template
    templateHelpers: () -> {error: @error}

    initialize: (@error) ->
      if not @error.reason
        switch @error.code
          when 403 then @error.reason = 'Forbidden'
          when 404 then @error.reason = 'Page Not Found'
          when 408 then @error.reason = 'Request Timed Out'
          when 500 then @error.reason = 'Internal Server Error'
          when 503 then @error.reason = 'Service Unavailable'
          else @error.reason = 'Unknown Error'

      @pageTitle = @error.reason
      super()

  return class ErrorPage extends MainPageView
    canonical: null

    initialize: (@error = {}) ->
      super()

    onRender: ->
      super()
      @regions.main.show(new InnerView(@error))
