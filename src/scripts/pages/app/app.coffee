define [
  'jquery'
  'underscore'
  'backbone'
  'cs!helpers/backbone/views/base'
  'hbs!./app-template'
  'less!./app'
], ($, _, Backbone, BaseView, template) ->

  return class AppView extends BaseView
    el: 'body'
    template: template()

    regions:
      main: '#main'
      header: '#header'
      footer: '#footer'

    initialize: () ->
      super()
      @$el.html(@template)

    render: (page, options) ->
      # Lazy-load the page
      require ["cs!pages/#{page}/#{page}"], (View) =>
        @regions.main.show(new View(options))
        window.scrollTo(0, 0)

      return @
