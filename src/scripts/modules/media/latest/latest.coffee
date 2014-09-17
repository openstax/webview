define (require) ->
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./latest-template')
  require('less!./latest')

  return class LatestView extends BaseView
    template: template
    templateHelpers:
      url: () ->
        page = ''
        id = @model.getUuid()
        title= @model.getBookTitle()

        if @model.isBook()
          page = ":#{@model.getPageNumber()}"

        return "#{settings.root}contents/#{id}/#{title}#{page}"

    initialize: () ->
      super()
      @listenTo(@model, 'change:isLatest change:currentPage', @render)
