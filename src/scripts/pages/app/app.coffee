define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  LegacyModal = require('cs!./modals/legacy')
  template = require('hbs!./app-template')

  return class AppView extends BaseView
    el: 'body'
    template: template

    regions:
      main: '#main'
      header: '#header'
      footer: '#footer'

    initialize: () ->
      super()
      @$el.html(@template)

      @regions.self.append(new LegacyModal())

    render: (page, options) ->
      # Lazy-load the page
      require ["cs!pages/#{page}/#{page}"], (View) =>
        @regions.main.show(new View(options))
        window.scrollTo(0, 0)

      return @
