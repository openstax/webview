define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  template = require('hbs!./error-template')
  require('less!./error')

  return class ErrorPage extends BaseView
    template: template
    templateHelpers: () -> {error: @error}
    canonical: null

    regions:
      find: '#find-content'

    initialize: (@error = {}) ->
      if not @error.reason
        switch @error.code
          when 403 then @error.reason = 'Forbidden'
          when 404 then @error.reason = 'Page Not Found'
          when 500 then @error.reason = 'Internal Server Error'
          when 503 then @error.reason = 'Service Unavailable'
          else @error.reason = 'Unknown Error'

      @pageTitle = @error.reason
      super()

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'error'}))
      @parent.regions.footer.show(new FooterView({page: 'error'}))

      @regions.find.show(new FindContentView())
