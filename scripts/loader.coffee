define [
  'jquery'
  'underscore'
  'backbone'
], ($, _, Backbone) ->

  init = () ->
    setup = (router) ->
      # Catch internal application links and let Backbone handle the routing
      $(document).on 'click', 'a:not([data-bypass])', (e) ->
        external = new RegExp('^((f|ht)tps?:)?//')
        href = $(this).attr('href')

        # Don't handle navigation if the default handling was already prevented
        if e.isDefaultPrevented() then return

        e.preventDefault();

        if external.test(href)
          window.open(href, '_blank')
        else
          router.navigate(href, {trigger: true})

      Backbone.history.start
        pushState: true

    require ['cs!routers/router'], (router) ->
      setup(router);

  return {init: init}
