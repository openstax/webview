define (require) ->
  EditableView = require('cs!helpers/backbone/views/editable')
  MetadataView = require('cs!./metadata/metadata')
  DownloadsView = require('cs!./downloads/downloads')
  HistoryView = require('cs!./history/history')
  AttributionView = require('cs!./attribution/attribution')
  LicenseView = require('cs!./license/license')
  template = require('hbs!./footer-template')
  require('less!./footer')

  return class MediaFooterView extends EditableView
    template: template

    regions:
      metadata: '.metadata'
      downloads: '.downloads'
      history: '.history'
      attribution: '.attribution'
      license: '.license'

    events:
      'click .tab': 'selectTab'

    editable:
      '[data-content="downloads"]':
        onEditable: ($el) -> $el.addClass('disabled')
        onUneditable: ($el) -> $el.removeClass('disabled')
      '[data-content="history"]':
        onEditable: ($el) -> $el.addClass('disabled')
        onUneditable: ($el) -> $el.removeClass('disabled')
      '[data-content="attribution"]':
        onEditable: ($el) -> $el.addClass('disabled')
        onUneditable: ($el) -> $el.removeClass('disabled')

    onRender: () ->
      @regions.metadata.show(new MetadataView({model: @model}))
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
