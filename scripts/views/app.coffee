define [
  'jquery'
  'underscore'
  'backbone'
  'cs!views/inherits/base'
  'less!styles/main'
], ($, _, Backbone, BaseView) ->

  return new class AppView extends BaseView
    el: 'body'

    regions:
      main: '#main'
      header: '#header'
      footer: '#footer'

    render: (page, options) ->
      # Lazy-load the page
      require ["cs!views/#{page}/layout"], (View) =>
        @regions.main.show(new View(options))

      return @
