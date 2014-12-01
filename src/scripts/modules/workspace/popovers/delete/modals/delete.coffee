define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./delete-template')
  settings = require('settings')
  $ = require('jquery')
  require('less!./delete')

  AUTHORING = "#{location.protocol}//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}"

  return class DeleteModal extends BaseView
    template: template

    templateHelpers: () ->
      title: @model.get('title')

    events:
      'click .ok' : 'deleteMedia'


    deleteMedia: () ->
      version = @model.get('version')
      # maybe make each item its own view and use a delete method on the model?
      # FIX: Look into making each list item its own view, remove data-id
      #      from template, and make its model the individual item.
      #      Probably dependent on search-results being made into a collection
      # FIX: Move delete function into node.coffee (@model.destroy())
      $.ajax
        url: "#{AUTHORING}/contents/#{version}/users/me"
        type: 'DELETE'
        xhrFields:
          withCredentials: true
      .done (response) =>
        @model.fetch()
      .fail (error) ->
        alert("#{error.status}: #{error.statusText}")


    show: () ->
      @render()
      $('#delete').modal('show')
