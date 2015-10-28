define (require) ->
  EditableView = require('cs!helpers/backbone/views/editable')
  DownloadsView = require('cs!modules/media/footer/downloads/downloads')
  HistoryView = require('cs!modules/media/footer/history/history')
  AttributionView = require('cs!modules/media/footer/attribution/attribution')
  LicenseView = require('cs!modules/media/footer/license/license')
  template = require('hbs!./footer-template')
  require('less!./footer')

  return class MediaFooterView extends EditableView
    template: template

    regions:
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
