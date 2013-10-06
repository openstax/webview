define (require) ->
  $ = require('jquery')
  content = require('cs!models/content')
  BaseView = require('cs!helpers/backbone/views/base')
  TocTreeView = require('cs!./contents/tree')
  template = require('hbs!./tabs-template')
  require('less!./tabs')

  return class MediaTabsView extends BaseView
    template: template

    regions:
      contents: '.contents'
      tools: '.tools'
      reading: '.reading-lists'

    events:
      'click .tab': 'selectTab'

    initialize: () ->
      super()
      @listenTo(@model, 'change:contents', @render)

    onRender: () ->
      @regions.contents.show(new TocTreeView({model: @model}))

    selectTab: (e) ->
      $tab = $(e.currentTarget)
      @switchTab($tab)

    switchTab: ($tab) ->
      @$el.find('.tab').addClass('inactive')
      @$el.find('.tab-content').hide()

      @$el.find('.tab').find('.expand').text('+')

      if $tab.data('content') isnt @currentTab
        $tab.removeClass('inactive')
        $tab.find('.expand').html('&minus;')
        @currentTab = $tab.data('content')
        @$el.find(".#{@currentTab}").show()
      else
        @currentTab = null
        @$el.find('.tab').removeClass('inactive')
