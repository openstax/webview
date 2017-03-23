define (require) ->
  (MediaTabsViewBase) ->
    _ = require('underscore')
    ToolsView = require('cs!./tools/tools')

    return class MediaTabsViewWithAuthoring extends MediaTabsViewBase
      templateHelpers: _.extend({}, MediaTabsViewBase.prototype.templateHelpers, {
        hasAuthoring: true
      })
      regions: _.extend({}, MediaTabsViewBase.prototype.regions, {
        tools: '.tools'
      })
      onRender: () ->
        @regions.tools.show(new ToolsView({model: @model}))
        super()
