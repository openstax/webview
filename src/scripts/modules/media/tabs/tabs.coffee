define (require) ->
  $ = require('jquery')
  content = require('cs!models/content')
  BaseView = require('cs!helpers/backbone/views/base')
  ContentsView = require('cs!./contents/contents')
  ToolsView = require('cs!./tools/tools')
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
      @regions.contents.show(new ContentsView({model: @model}))
      @regions.tools.show(new ToolsView({model: @model}))

    selectTab: (e) ->
      $tab = $(e.currentTarget)
      @switchTab($tab)

    switchTab: ($tab) ->
      $allTabs = @$el.find('.tab')
      $allTabs.addClass('inactive')
      $allTabs.removeClass('active')
      @$el.find('.tab-content').hide()

      if $tab.data('content') isnt @currentTab
        $tab.removeClass('inactive')
        $tab.addClass('active')
        @currentTab = $tab.data('content')
        @$el.find(".#{@currentTab}").show()
      else
        @currentTab = null
        $allTabs.removeClass('inactive')
