define (require) ->
  $ = require('jquery')
  content = require('cs!models/content')
  BaseView = require('cs!helpers/backbone/views/base')
  ContentsView = require('cs!./contents/contents')
  MetadataView = require('cs!./metadata/metadata')
  ToolsView = require('cs!./tools/tools')
  template = require('hbs!./tabs-template')
  require('less!./tabs')

  return class MediaTabsView extends BaseView
    template: template
    templateHelpers:
      book: () -> @model.isBook()

    regions:
      contents: '.contents'
      metadata: '.metadata'
      tools: '.tools'

    events:
      'click .tab': 'selectTab'

    initialize: () ->
      super()
      @listenTo(@model, 'change:contents', @render)

    onRender: () ->
      @regions.contents.show(new ContentsView({model: @model}))
      @regions.metadata.show(new MetadataView({model: @model}))
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
