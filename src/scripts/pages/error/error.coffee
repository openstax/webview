define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  template = require('hbs!./error-template')
  require('less!./error')

  class InnerView extends BaseView
    template: template
    templateHelpers: () -> {error: @error}

    initialize: (@error) ->
      @pageTitle = @error.reason || 'error-page-reason'
      @pageTitleArgs = {code:@error.code}
      super()

  return class ErrorPage extends MainPageView
    canonical: null

    initialize: (@error = {}) ->
      super()

    onRender: ->
      super()
      @regions.main.show(new InnerView(@error))
