define (require) ->
  ContentView = require('cs!helpers/backbone/views/content')
  DownloadsView = require('cs!./downloads/downloads')
  HistoryView = require('cs!./history/history')
  AttributionView = require('cs!./attribution/attribution')
  MetadataView = require('cs!./metadata/metadata')
  LicenseView = require('cs!./license/license')
  template = require('hbs!./footer-template')
  linksHelper = require('cs!helpers/links')
  require('less!./footer')

  return class MediaFooterView extends ContentView
    template: template

    templateHelpers:
      minimal: () ->
        queryString = linksHelper.serializeQuery(location.search)
        if queryString.minimal
          return true
        return false

    regions:
      downloads: '.downloads'
      history: '.history'
      attribution: '.attribution'
      license: '.license'
      metadata: '.metadata'

    events:
      'click .tab': 'selectTab'
      'keydown .tab': 'keySelectTab'

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
      @regions.metadata.show(new MetadataView({model: @model}))

    keySelectTab: (e) ->
      if e.keyCode is 13 or e.keyCode is 32
        e.preventDefault()
        $(e.currentTarget).click()

    selectTab: (e) ->
      $tab = $(e.currentTarget)
      @switchTab($tab)

    switchTab: ($tab) ->
      if $tab.hasClass('disabled') then return

      $allTabs = @$el.find('.tab')
      $allTabs.addClass('inactive')
      $allTabs.removeClass('active')
      @$el.find('.tab-content').hide().attr('aria-hidden', 'true')

      if $tab.data('content') isnt @currentTab
        $tab.removeClass('inactive')
        $tab.addClass('active')
        @currentTab = $tab.data('content')
        @$el.find(".#{@currentTab}").show().removeAttr('aria-hidden')
      else
        @currentTab = null
        $allTabs.removeClass('inactive')
