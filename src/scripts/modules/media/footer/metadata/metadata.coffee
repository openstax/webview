define (require) ->
  _ = require('underscore')
  linksHelper = require('cs!helpers/links')
  Backbone = require('backbone')
  settings = require('settings')
  subjects = require('cs!collections/subjects')
  FooterTabView = require('cs!modules/media/footer/inherits/tab/tab')
  template = require('hbs!./metadata-template')
  require('bootstrapTooltip')
  require('less!./metadata')

  authoringport = if settings.cnxauthoring.port then ":#{settings.cnxauthoring.port}" else ''
  AUTHORING="//#{settings.cnxauthoring.host}#{authoringport}"

  s2Defaults = width: 300
  s2Multi = _.extend {}, s2Defaults, {minimumInputLength: 2, ajax: quietMillis: 500}

  return class MetadataView extends FooterTabView
    key = []
    template: template
    templateHelpers: () ->
      model = super()
      model.languages = settings.languages
      model.languageName = settings.languages[model.language]
      model.subjectsList = subjects.list
      model.url = linksHelper.getModelPath(model)
      model.printStyles =
        {
          'default' : 'Default',
          'ccap-physics' : 'CCAP Physics',
          'ccap-sociology' : 'CCAP Sociology',
          'ccap-biology' : 'CCAP Biology',
          'ccap-anatomy' : 'CCAP Anatomy',
          'ccap-statistics' : 'CCAP Statistics',
          'ccap-precalculus' : 'CCAP Precalculus',
          'ccap-psychology' : 'CCAP Psychology',
          'ccap-economics' : 'CCAP Economics',
          'ccap-history' : 'CCAP History',
          'ccap-chemistry' : 'CCAP Chemistry'
        }
      model.printStyleName = model.printStyles[model.printStyle]

      if @media is 'page'
        editable = if @model.isBook() then @model.get('currentPage')?.isEditable() else @model.isEditable()
      else
        editable = @model.isEditable()

      model.editable = editable

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
          _.extend({}, s2Defaults, tags: @getProperty('keywords') or [])

      '.printStyle > select':
        value: 'printStyle'
        type: 'select2'
        select2: s2Defaults

      '.authors > input':
        value: 'authors'
        type: 'select2'
        select2: () -> @getUsers({collection: @authorsCollection, role: 'authors', critical: true})
        setValue: (property, value, options) ->
          authors = []
          _.each value, (author) =>
            authors.push(@authorsCollection.get(author).toJSON())
          return authors

      '.licensors > input':
        value: 'licensors'
        type: 'select2'
        select2: () -> @getUsers({collection: @licensorsCollection, role: 'licensors', critical: true})
        setValue: (property, value, options) ->
          licensors = []
          _.each value, (licensor) =>
            licensors.push(@licensorsCollection.get(licensor).toJSON())
          return licensors

      '.publishers > input':
        value: 'publishers'
        type: 'select2'
        select2: () -> @getUsers({collection: @publishersCollection, role: 'publishers'})
        setValue: (property, value, options) ->
          publishers = []
          _.each value, (publisher) =>
            publishers.push(@publishersCollection.get(publisher).toJSON())
          return publishers

    initialize: () ->
      super()

      # Lookup because select2 only allows string values
      # but we need to keep the name and the id for each user
      @users = {}

      # Store authors, licensors and publishers in Backbone Collections since Select2 does not
      # allow storing more than an id on a tag, but we need to send
      # the full objects on save
      @authorsCollection = new Backbone.Collection()
      @licensorsCollection = new Backbone.Collection()
      @publishersCollection = new Backbone.Collection()

      @listenTo @model, 'change change:currentPage', (model, options) =>
        @render() unless options?.doNotRerender

    getUsers: (options = {}) ->
      collection = options.collection

      roles = @getProperty(options.role)
      collection.add(roles)

      userRoles = _.map roles, (item) =>
        if typeof item is 'string'
          return @users[item]
        else
          user = {id: item.id, text: @displayName(item.fullname, item.id), state: 'pending'}
          if item.hasAccepted is true
            user.state = 'accepted'
          else if item.hasAccepted is false
            user.state = 'rejected'
          @users["#{user.id}"] = user

          return user

      if options.critical and userRoles.length is 1
        userRoles[0].locked = true

      _.extend {}, s2Multi,
        id: (item) -> item.id
        initSelection: (el, cb) -> cb(userRoles)
        multiple: true
        formatSelectionCssClass: (user, container) -> user.state or 'pending'
        ajax:
          url: "#{AUTHORING}/users/search"
          dataType: 'json'
          params:
            xhrFields:
              withCredentials: true
          data: (term, page) ->
            q: term # search term

          results: (data, page) => # parse the results into the format expected by Select2.
            collection.add(data.users)
            return {
              results: _.map data.users, (item) =>
                user = {id: item.id, text: @displayName(item.fullname, item.id)}
                @users["#{user.id}"] = user
                return user
            }

    displayName: (fullname, id) ->
      if fullname isnt null
        return "#{fullname} (#{id})"
      else
        return id

    onRender: () ->
      super()
      @$el.find('[data-toggle="tooltip"]').tooltip()

