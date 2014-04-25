define (require) ->
  EditableView = require('cs!helpers/backbone/views/editable')
  DownloadsView = require('cs!./downloads/downloads')
  HistoryView = require('cs!./history/history')
  AttributionView = require('cs!./attribution/attribution')
  LicenseView = require('cs!./license/license')
  template = require('hbs!./footer-template')
  require('less!./footer')

  return class MediaFooterView extends EditableView
    template: template

    regions:
      downloads: '.downloads'
      history: '.history'
      attribution: '.attribution'
      license: '.license'

    events:
      'click .tab': 'selectTab'

    editable:
      '[data-content="downloads"]':
        start: ($el) -> $el.addClass('disabled')
        stop: ($el) -> $el.removeClass('disabled')
      '[data-content="history"]':
        start: ($el) -> $el.addClass('disabled')
        stop: ($el) -> $el.removeClass('disabled')
      '[data-content="attribution"]':
        start: ($el) -> $el.addClass('disabled')
        stop: ($el) -> $el.removeClass('disabled')

    onRender: () ->
      @regions.downloads.show(new DownloadsView({model: @model}))
      @regions.history.show(new HistoryView({model: @model}))
      @regions.attribution.show(new AttributionView({model: @model}))
      @regions.license.show(new LicenseView({model: @model}))

    selectTab: (e) ->
      $tab = $(e.currentTarget)
      @switchTab($tab)

    switchTab: ($tab) ->
      if $tab.hasClass('disabled') then return

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
