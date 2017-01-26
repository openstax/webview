define (require) ->
  _ = require('underscore')
  MediaTabsView = require('cs!./tabs-base')
  ToolsView = require('cs!./tools/tools')

  return class MediaTabsViewWithAuthoring extends MediaTabsView
    templateHelpers: _.extend({}, MediaTabsView.prototype.templateHelpers, {
      hasAuthoring: true
    })
    regions: _.extend({}, MediaTabsView.prototype.regions, {
      tools: '.tools'
    })
    onRender: () ->
      @regions.tools.show(new ToolsView({model: @model}))
      super()
