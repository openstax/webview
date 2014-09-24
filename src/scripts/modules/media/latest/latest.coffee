define (require) ->
  linksHelper = require('cs!helpers/links')
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
        version = @model.get('version')
        title= @model.getBookTitle().replace(/\ /g,'_').substring(0,30)

        if @model.isBook()
          page = ":#{@model.getPageNumber()}"

        return "#{settings.root}contents/#{id}#{page}/#{title}"

    initialize: () ->
      super()
      @listenTo(@model, 'change:isLatest change:currentPage', @render)
