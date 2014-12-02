define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('settings')
  Collection = require('cs!models/contents/collection')
  Page = require('cs!models/contents/page')

  return class Content extends Collection
    relations: [{
      type: Backbone.Many
      key: 'contents'
      relatedModel: (relation, attributes) ->
        return (attrs, options) =>
          # FIX: Consider putting all added fields under _meta to make removal before saving simple
          attrs._parent = @
          attrs.depth = 0
          attrs.book = @
          if _.isArray(attrs.contents)
            delete attrs.id # Get rid of the 'subcol' id so the section is unique
            return new Collection(attrs)

          return new Page(attrs)
    }]

    initialize: (options = {}) ->
      @set('loaded', false)

      # Immediately load content that has an id
      if @id
        @set('version', options.version) if options.version
        @fetch
          reset: true
        .always () =>
          @set('loaded', true)
        .done () =>
          @set('error', false)
          if @isBook()
            if @get('contents').length
              @setPage(options.page or 1) # Default to page 1
          else
            @set('active', true)

        .fail (model, response, options) =>
          @set('error', response?.status or model?.status or 9000)

    parse: (response, options = {}) ->
      super(arguments...)

      # Mark drafts as being in edit mode by default if user has edit permission
      if @isDraft() and response.status isnt 'publishing' and _.indexOf(response.permissions, 'edit')
        response.editable = true

      return response

    save: (key, val, options) ->
      if not key? or typeof key is 'object'
        attrs = key
        options = val
      else
        attrs = {}
        attrs[key] = val

      options = _.extend(
        includeTree: true
        excludeContents: true
      , options)

      return super(attrs, options).done () =>
        @set('changed', false)
        @set('childChanged', false)

    toJSON: (options = {}) ->
      results = super(arguments...)

      # Prevent new books with no id from being labelled a subcollection
      if results.id is 'subcol'
        delete results.id

      if options.includeTree and @isBook()
        results.tree =
          id: @getVersionedId()
          title: @get('title')
          contents: @get('contents')?.toJSON?({serialize_keys: ['id', 'title', 'contents']}) or []

      if options.excludeContents
        delete results.contents

      return results

    # Proxy page events on this object
    @_proxyChange: (eventName, page, value) ->
      if eventName.indexOf(':currentPage') > -1
        return

      if eventName.slice(0, 7) is 'change:'
        @trigger("change:currentPage.#{eventName.slice(7)}", page, value)

    _setPage: (page) ->
      currentPage = @get('currentPage')

      if currentPage
        currentPage.off(null, null, Content._proxyChange)
        currentPage.set('active', false)

      @set('currentPage', page)

      if page
        page.on('all', (() => Content._proxyChange.apply(@, arguments)))
        page.set('active', true)

        if not page.get('loaded')
          page.fetch().done () ->
            page.set('loaded', true)
      else
        @trigger('change:currentPage.loaded')

    _lookupPage: (page) ->
      if typeof page is 'number'
        # Do not skip if the currentPage is the arg being passed in
        # because otherwise it will not get fetched
        pages = @getTotalPages()
        if page < 1 then page = 1
        if page > pages then page = pages

      return @getPage(page)

    setPage: (page) -> @_setPage(@_lookupPage(page))

    getTotalPages: () ->
      # FIX: cache total pages and recalculate on add/remove events?
      return @getTotalLength()

    getPageNumber: (model = @asPage()) -> super(model)

    getNextPageNumber: () ->
      if not @get('loaded') then return 0
      pages = @getTotalPages()

      page = @getPageNumber()
      if page < pages then ++page
      return page

    getPreviousPageNumber: () ->
      if not @get('loaded') then return 0
      page = @getPageNumber()
      if page > 1 then --page
      return page

    deriveCurrentPage: (options = {}) ->
      options = _.extend({wait: true}, options)

      if @isBook()
        page = @get('currentPage')
        parent = page.get('_parent')
        title = page.get('title')
        id = page.id
        index = parent.get('contents').indexOf(page)

        options = _.extend({at: index}, options)

        parent.get('contents').remove(page)
        parent.create({title: title, derivedFrom: id}, options)
        @set('changed', true)
      else
        @derive(options)

    removeNode: (node) ->
      # FIX: get previous page even if removing a section
      #previousPage = @getPageNumber(@getPreviousNode(node))
      previousPage = @getPageNumber(node) - 1

      node.get('_parent').get('contents').remove(node)

      # FIX: determine if node was inside a section that got removed too
      if node is @asPage()
        @setPage(previousPage)

      @set('changed', true)
      @trigger('removeNode')

    move: (node, marker, position) ->
      oldContainer = node.get('_parent')
      container = marker.get('_parent')

      # Prevent a node from trying to become its own ancestor (infinite recursion)
      if marker.hasAncestor(node)
        return node

      # Remove the node
      oldContainer.get('contents').remove(node)

      if position is 'insert'
        index = 0
        container = marker
      else
        index = marker.index()
        if position is 'after' then index++

      # Mark the node's parent, node's old parent, and book as changed
      oldContainer.set('changed', true)
      container.set('changed', true)
      @set('changed', true)

      # Re-add the node in the correct position
      container.get('contents').add(node, {at: index})

      # Update the node's parent
      node.set('_parent', container)

      # Update the node's depth
      if container.has('depth')
        node.set('depth', 1 + container.get('depth'))
      else
        node.set('depth', 0)

      @trigger('moveNode')
      return node

    # Content can be a Book or a Page and some views render
    # parts of the current page.
    # This will return:
    # - `null` if this content has not been loaded yet
    # - the current page (if this is a book)
    # - this if this is a page
    asPage: () ->
      if @isBook()
        return @get('currentPage')

      return @
