define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('settings')
  subjects = require('cs!collections/subjects')
  FooterTabView = require('cs!modules/media/footer/inherits/tab/tab')
  template = require('hbs!./metadata-template')
  require('less!./metadata')

  s2Defaults = width: 300
  s2Multi = _.extend {}, s2Defaults, minimumInputLength: 2

  # Lookup because select2 only allows string values
  # but we need to keep the name and the id for each user
  users = {}

  # Store authors in a Backbone Collection since Select2 does not
  # allow storing more than an id on a tag, but we need to send
  # the full author object on save
  authorsCollection = new Backbone.Collection()

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

      # FIX: The summary field is taking focus aggressively, making the body
      #      lose focus and making it impossible to toggle from Page to Book
      #'.summary':
      #  value: 'abstract'
      #  type: 'aloha'

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
          authorsCollection.add(@getProperty('authors'))
          authors = _.map @getProperty('authors'), (item) ->
            if typeof item is 'string'
              return users[item]
            else
              user = {id: item.id, text: item.fullname or item.id}
              users["#{user.id}"] = user
              return user

          _.extend {}, s2Multi,
            id: (item) -> item.id
            # data: authors
            initSelection: (el, cb) -> cb(authors)
            multiple: true
            formatResult: (item, $container, query) -> $('<div></div>').append(item.text)
            ajax:
              url: "//#{settings.cnxauthoring.host}:#{settings.cnxauthoring.port}/users/search"
              dataType: 'json'
              params:
                xhrFields:
                  withCredentials: true
              data: (term, page) ->
                q: term # search term

              results: (data, page) -> # parse the results into the format expected by Select2.
                authorsCollection.add(data.users)
                return {
                  results: _.map data.users, (item) ->
                    user = {id: item.id, text: item.fullname or item.id}
                    users["#{user.id}"] = user
                    return user
                }

        setValue: (property, value, options) ->
          authors = []

          _.each value, (author) ->
            authors.push(authorsCollection.get(author).toJSON())

          return authors

    initialize: () ->
      super()
      @listenTo @model, 'change change:currentPage', (model, options) =>
        @render() unless options?.doNotRerender
