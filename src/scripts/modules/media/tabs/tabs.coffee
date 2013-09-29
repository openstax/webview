define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./tabs-template')
  require('less!./tabs')

  return class MediaTabsView extends BaseView
    template: template

    events:
      'click .tab': 'selectTab'

    selectTab: (e) ->
      $tab = $(e.currentTarget)
      @switchTab($tab)

    switchTab: ($tab) ->
      @$el.find('.tab').addClass('inactive')
      $tab.removeClass('inactive')

      @$el.find('.tab-content').hide()
      @$el.find(".#{$tab.data('content')}").show()
