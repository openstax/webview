define (require) ->
  settings = require('settings')
  subjects = require('cs!collections/subjects')
  FooterTabView = require('cs!modules/media/footer/inherits/tab/tab')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  s2Defaults = width: 300
  s2Multi = _.extend {}, s2Defaults, minimumInputLength: 2


  # Lookup because select2 only allows string values
  # but we need to keep the name and the id for each user
  allUsers = {}

  return class MetadataView extends FooterTabView
    template: template
    templateHelpers: () ->
      model = super()
      model.languages = settings.languages
      model.languageName = settings.languages[model.language]
      model.subjectsList = subjects.list
      return model

    editable:
      '.language > select':
        value: 'language'
        type: 'select2'
        select2: s2Defaults
      '.summary':
        value: 'abstract'
        type: 'aloha'
      '.subjects > select':
        value: 'subjects'
        type: 'select2'
        select2: s2Defaults
      '.keywords > input':
        value: 'keywords'
        type: 'select2'
        select2: () ->
          @$el.find('.keywords > input').val(@getProperty('keywords') or [])
          _.extend({}, s2Multi, tags: @getProperty('keywords') or [])
      '.authors > input':
        value: 'authors'
        type: 'select2'
        select2: () ->
          authors = _.map @getProperty('authors'), (item) ->
            if not item
              console.log 'item is null KJSDHFSKDJHF'
            if typeof item is 'string'
              return allUsers[item]
            else
              idText = {id:item.id, text:item.fullname}
              allUsers["#{idText.id}"] = idText
              return idText

          # @$el.find('.authors > input').val(_.map(authors, (item) -> item.id))
          _.extend {}, s2Multi,
            id: (item) -> item.id
            # data: authors
            initSelection: (el, cb) ->
              cb(authors)
            multiple: true
            formatResult: (item, $container, query) -> $('<div></div>').append(item.text)
            ajax:
              url: "#{window.location.origin}/users/search"
              dataType: 'json'
              data: (term, page) ->
                q: term # search term

              results: (data, page) -> # parse the results into the format expected by Select2.
                results: _.map data.users, (item) ->
                  idText = {id:item.id, text:item.full_name or item.username}
                  allUsers["#{idText.id}"] = idText
                  return idText

    initialize: () ->
      super()
      @listenTo @model, 'change change:currentPage', (model, options) =>
        @render() unless options?.doNotRerender
