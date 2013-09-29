define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  analytics = require('cs!helpers/handlers/analytics')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tabs-template')
  require('less!./tabs')

  return class MediaTabsView extends BaseView
    template: template

    events:
      'click .tab': 'selectTab'
      'click .contents .subcollection': 'toggleSubcollection'
      'click .contents a': 'loadPage'

    selectTab: (e) ->
      $tab = $(e.currentTarget)
      @switchTab($tab)

    switchTab: ($tab) ->
      @$el.find('.tab').addClass('inactive')
      $tab.removeClass('inactive')

      @$el.find('.tab-content').hide()
      @$el.find(".#{$tab.data('content')}").show()

    toggleSubcollection: (e) ->
      $(e.currentTarget).parent().siblings('ul').toggle()

    loadPage: (e) ->
      e.preventDefault()
      $a = $(e.currentTarget)

      @model.setPage($a.data('page'))
      route = $a.attr('href')
      router.navigate(route) # Update browser URL to reflect the new route
      analytics.send() # Send the analytics information for the new route
