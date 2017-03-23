define (require) ->
  $ = require('jquery')
  linksHelper = require('cs!helpers/links')
  BaseView = require('cs!helpers/backbone/views/base')
  ContentsView = require('cs!./contents/contents')
  MetadataView = require('cs!./metadata/metadata')
  template = require('hbs!./tabs-template')
  require('less!./tabs')

  return class MediaTabsView extends BaseView
    template: template
    templateHelpers:
      isBook: () -> @model.isBook()
      hasAuthoring: false

    regions:
      contents: '.contents'

    events:
      'click .tab': 'selectTab'
      'keydown .tab': 'selectTabWithKeyboard'

    initialize: () ->
      super()
      @listenTo(@model, 'change:contents', @render)

    onRender: () ->
      @regions.contents.show(new ContentsView({model: @model}))

      components = linksHelper.getCurrentPathComponents()

      if components.query?.tab
        @resetTabs()
        @showTab(@$el.find(".#{components.query.tab}-tab"))

    selectTabWithKeyboard: (e) ->
      if e.keyCode is 13 or e.keyCode is 32
        e.preventDefault()
        $tab = $(e.currentTarget)
        @switchTab($tab)

    selectTab: (e) ->
      $tab = $(e.currentTarget)
      @switchTab($tab)

    resetTabs: () ->
      $allTabs = @$el.find('.tab')
      $allTabs.addClass('inactive')
      $allTabs.removeClass('active')
      $allTabs.attr('aria-selected', 'false')
      @$el.find('.tab-content').hide().attr('aria-hidden', 'true')

    showTab: ($tab) ->
      $tab.removeClass('inactive')
      $tab.addClass('active')
      $tab.attr('aria-selected', 'true')
      @currentTab = $tab.data('content')
      @$el.find(".#{@currentTab}").show().removeAttr('aria-hidden')

    closeTabs: () ->
      $allTabs = @$el.find('.tab')
      @currentTab = null
      $allTabs.removeClass('inactive')

    switchTab: ($tab) ->
      @resetTabs()

      if $tab.data('content') isnt @currentTab
        @showTab($tab)
      else
        @closeTabs()
