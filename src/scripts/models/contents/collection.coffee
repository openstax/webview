define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Backbone = require('backbone')
  Node = require('cs!./node')
  Page = require('cs!./page')
  require('backbone-associations')

  return class Collection extends Node
    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: (relation, attributes) ->
        return (attrs, options) =>
          attrs._parent = @
          if _.isArray(attrs.contents)
            delete attrs.id # Get rid of the 'subcol' id so the section is unique
            return new Collection(attrs)

          return new Page(attrs)
    }]

    introduction: ->
      return unless @isCcap() and @isSection()
      firstChild = @get('contents')?.models?[0]
      return if firstChild.isSection()
      firstChild

    cachedPages: undefined

    getTotalLength: () ->
      (@cachedPages or @allPages()).length

    _getPageNum: (num) ->
      pages = @cachedPages or @allPages()
      return pages[0] if (num <= 1)
      return pages[page.length - 1] if (num > pages.length)
      return pages[num - 1]

    allPages: (nodes=@get('contents').models, collection=[]) ->
      _.each nodes, (node) =>
        if node.isSection()
          children = node.get('contents').models
          @allPages(children, collection)
        else
          collection.push(node)
      collection

    _getPageFromId: (id) ->
      pages = @cachedPages or @allPages()
      idPattern = ///^#{id}///
      for page in pages
        id = page.get('id')
        if page.get('id').match(idPattern) or
        page.get('shortId').match(idPattern)
          return page

      return

    getPage: (page) ->
      if typeof page is 'number'
        return @_getPageNum(page)

      return @_getPageFromId(page)

    toJSON: (options = {}) ->
      results = super(arguments...)

      # FIX: Subcollections having the id 'subcol' is kind of awkward, can this be removed from the db?
      results.id = @getVersionedId() or 'subcol'

      return results


    #
    # Proxy Backbone.Collection methods to make this model also work like a Collection
    #

    add: () ->
      results = @get('contents').add(arguments...)
      @set('changed', true)
      @trigger('add')

      return results

    create: (models, options = {}) ->
      options = _.extend({
        xhrFields:
          withCredentials: true
        wait: true # Wait for a server response before adding the model to the collection
        excludeTransient: true # Remove transient properties before saving to the server
      }, options)

      if not _.isArray(models) then models = [models]

      contents = @get('contents')
      _.each models, (model) ->
        if model.derivedFrom
          opts = _.extend({derivedOnly: true}, options)

        contents.create(model, opts or options)

      @set('changed', true)

      return @

    save: () ->
      # save args for call to `super()`
      args = arguments
      # First, save all the models in the collection
      promises = _.map @get('contents')?.models, (model) -> model.save()

      # Save the collection once all the models have completed saving
      return $.when(promises...).then () =>
        # Don't save subcollections
        if @isSaveable()
          xhr = super(args...).then () =>
            @set('changed', false)
            @set('childChanged', false)
        else
          xhr = $.Deferred().resolve().promise()

        return xhr
