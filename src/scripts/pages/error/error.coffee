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

    regions:
      find: '#find-content'

    initialize: (@error = {}) ->
      if not @error.message
        switch @error.code
          when 403 then @error.message = 'Forbidden'
          when 404 then @error.message = 'Page Not Found'
          when 500 then @error.message = 'Internal Server Error'
          when 503 then @error.message = 'Service Unavailable'
          else @error.messsage = 'Unknown Error'

      @pageTitle = @error.message
      super()

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'error'}))
      @parent.regions.footer.show(new FooterView({page: 'error'}))

      @regions.find.show(new FindContentView())
