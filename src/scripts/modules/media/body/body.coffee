define (require) ->
  $ = require('jquery')
  embeddablesConfig = require('cs!configs/embeddables')
  Mathjax = require('mathjax')
  router = require('cs!router')
  EditableView = require('cs!helpers/backbone/views/editable')
  template = require('hbs!./body-template')
  require('less!./body')

  embeddableTemplates = {
    'exercise' : require('hbs!./embeddables/exercise-template'),
    'iframe' : require('hbs!./embeddables/iframe-template')
  }

  fakeExerciseTemplates = [
    require('hbs!./embeddables/fake-exercises/ex001')
    require('hbs!./embeddables/fake-exercises/ex002')
    require('hbs!./embeddables/fake-exercises/ex003')
    require('hbs!./embeddables/fake-exercises/ex004')
  ]

  return class MediaBodyView extends EditableView
    media: 'page'
    template: template
    templateHelpers:
      editable: () -> @model.get('currentPage')?.isEditable()
      content: () -> @model.asPage()?.get('content')
      hasContent: () -> typeof @model.asPage()?.get('content') is 'string'
      loaded: () ->
        if @model.isBook() and @model.getTotalLength()
          return @model.asPage()?.get('loaded')

        return @model.get('loaded')

    editable:
      '.media-body':
        value: () -> 'content'
        type: 'aloha'

    events:
      'click a': 'changePage'
      'click [data-type="solution"] > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'
      'click .solution > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'

    initialize: () ->
      super()
      @listenTo(@model, 'change:loaded', @render)
      @listenTo(@model, 'change:currentPage change:currentPage.active change:currentPage.loaded', @render)
      @listenTo(@model, 'change:currentPage.editable', @render)

    # Perform mutations to the HTML before loading it on to the page for better performance
    renderDom: () ->
      $temp = $('<div>').html(@getTemplate())

      try
        if @model.get('loaded') and @model.asPage()?.get('loaded') and @model.asPage()?.get('active')

          # Remove the module title and abstract TODO: check if it is still necessary
          $temp.children('[data-type="title"]').remove()
          $temp.children('[data-type="abstract"]').remove()

          # Wrap title and content elements in header and section elements, respectively
          $temp.find('.example, .exercise, .note,
                    [data-type="example"], [data-type="exercise"], [data-type="note"]').each (index, el) ->
            $el = $(el)
            $contents = $el.contents().filter (i, node) ->
              return !$(node).is('.title, [data-type="title"]')
            $contents.wrapAll('<section>')
            $title = $el.children('.title, [data-type="title"]')
            $title.wrap('<header>')
            # Add an attribute for the parents' `data-label`
            # since CSS does not support `parent(attr(data-label))`.
            # When the title exists, this attribute is added before it
            $title.attr('data-label-parent', $el.attr('data-label'))
            # Add a class for styling since CSS does not support `:has(> .title)`
            # NOTE: `.toggleClass()` explicitly requires a `false` (not falsy) 2nd argument
            $el.toggleClass('ui-has-child-title', $title.length > 0)

          # Wrap solutions in a div so "Show/Hide Solutions" work
          $temp.find('.solution, [data-type="solution"]')
          .wrapInner('<section class="ui-body">')
          .prepend('''
            <div class="ui-toggle-wrapper">
              <button class="btn-link ui-toggle" title="Show/Hide Solution"></button>
            </div>''')

          $temp.find('figure:has(> figcaption)').addClass('ui-has-child-figcaption')

          # Move all figure captions below the figure
          $temp.find('figcaption').each (i, el) ->
            $(el).parent().append(el)

          # Convert figure and table links to show the proper name
          $temp.find('a:not([data-type=footnote-number])').each (i, el) ->
            $el = $(el)
            href = $el.attr('href')

            if href.substr(0, 1) is '#' and href.length > 1 and $el.data('type') isnt 'footnote-ref'
              # trying to find elements with '/' in ids was causing errors.
              # Will move things to test links elsewhere once I find out where I should put them
              if href.search(/\//) > -1
                return
              $target = $temp.find(href)
              tag = $target?.attr('data-type')?.toLowerCase()
              if $el.text() is '[link]' and tag
                tag = tag.charAt(0).toUpperCase() + tag.substring(1)
                $el.text("#{tag}") if tag isnt 'undefined'

          # Convert links to maintain context in a book, if appropriate
          if @model.isBook()
            $temp.find('a:not([data-type=footnote-number])').each (i, el) =>
              $el = $(el)
              href = $el.attr('href')

              if href.substr(0, 1) isnt '#'
                page = @model.getPage(href.substr(10))

                if page
                  pageNumber = page.getPageNumber()
                  $el.attr('href', "/contents/#{@model.getVersionedId()}:#{pageNumber}")
                  $el.attr('data-page', pageNumber)

          # Add nofollow to external user-generated links
          $temp.find('a[href^="http:"], a[href^="https:"], a[href^="//"]').attr('rel', 'nofollow')

          # Copy data-mark-prefix and -suffix from ol to li so they can be used in css
          $temp.find('ol[data-mark-prefix] > li, ol[data-mark-suffix] > li,
          [data-type="list"][data-list-type="enumerated"][data-mark-prefix] > [data-type="item"],
          [data-type="list"][data-list-type="enumerated"][data-mark-suffix] > [data-type="item"]').each (i, el) ->
            $el = $(el)
            $parent = $el.parent()
            $el.attr('data-mark-prefix', $parent.data('mark-prefix'))
            $el.attr('data-mark-suffix', $parent.data('mark-suffix'))
          $temp.find('ol[start], [data-type="list"][data-list-type="enumerated"][start]').each (i, el) ->
            $el = $(el)
            $el.css('counter-reset', 'list-item ' + $el.attr('start'))

          # # uncomment to embed fake exercises and see embeddable exercises in action
          # @fakeExercises($temp)

          @initializeEmbeddableQueues()
          @findEmbeddables($temp.find('#content'))

      catch error
        # FIX: Log the error
        console.log error

      @$el?.html($temp.html())



    ###
    # For handling embeddables (exercises from Tutor, concept coaches, simulations, etc).
    # Could abstract a little more and pull out to another file if needed.
    ###

    # A queue for rendering embeddables means
    # we can share rendering functions regardless
    # of whether the embeddable is sync or async
    initializeEmbeddableQueues: () ->
      @renderEmbeddableQueue = []

      _.extend(@renderEmbeddableQueue, Backbone.Events)

      @renderEmbeddableQueue?.on('add', @renderEmbeddable)
      # Uncomment to add action for messages
      #
      # There's only one right now for when all the asyncs are done
      # @renderEmbeddableQueue?.on('message', (message) ->)

    renderEmbeddable : (embeddable) =>
      # finds fresh element in @$el if a selector is provided
      # instead of the element itself.
      embeddable.$el = @$el.find(embeddable.selector) if embeddable.selector
      embeddable.$el.replaceWith(embeddable.html)

    # handles all embeddables -- finds and processes them
    # to be handled by render queue
    #
    # both for where embedded html is an iframe sourced to the api link ("sync", loosely used)
    # or rendered html after an async api call ("async", loosely used)
    findEmbeddables: ($parent) ->

      # container for promises from async embeddables
      # holds all promises and when all promises come back,
      # render queue is sent a message
      embeddablePromises = []

      # caches all elements that need to be checked for whether it's an embeddable
      $elementsToFilter = {
        a : $parent.find('a'),
        iframe : $parent.find('iframe')
      }

      # Add embeddable types as needed in embeddablesConfig
      embeddableTypes = embeddablesConfig.embeddableTypes

      # process each embeddable type
      _.each(embeddableTypes, (embeddable) ->

        embeddable.matchAttr = if embeddable.matchType is 'a' then 'href' else 'src'
        matchAttrString = '[' + embeddable.matchAttr + '*="' + embeddable.match + '"]'

        # filter for embeddables matching the type!
        $matchedEmbeddables = $elementsToFilter[embeddable.matchType].filter(matchAttrString)

        promises = @addEmbeddablesToRenderQueue(embeddable, $matchedEmbeddables)

        # store promises for all async added to queue message
        embeddablePromises.push(promises)
        # Exclude embeddables from cache that are already being processed
        # The next embeddable type loop through will then completely exclude those elements
        $elementsToFilter[embeddable.matchType] = $elementsToFilter[embeddable.matchType].not($matchedEmbeddables)

      , @)

      embeddablePromises = _.flatten(embeddablePromises)
      # tell the queue when async embeddables have been all been added!
      $.when.apply(@, embeddablePromises).then(() =>
        @renderEmbeddableQueue.trigger('message', 'async embeddables added to queue')
      )

    # where the magic happens
    addEmbeddablesToRenderQueue: (embeddable, $embeddables) =>

      # map to track result from adding each embeddable to the queue
      promises = _.map($embeddables, (embeddableElement) ->

        $embeddableElement = $(embeddableElement)
        embeddableItem = @getEmbeddableItem(embeddable, $embeddableElement)

        # if the embeddable is async, it needs to do an external call
        # to get information to feed to the template for the embeddableType
        if embeddableItem.async
          embeddableItem.template = embeddableTemplates[embeddableItem.embeddableType]
          # returns promise for AJAX call and adds to render queue
          # with data from AJAX call
          return @setHTMLFromAPI(embeddableItem, $embeddableElement).then(@_addToRenderQueue)

        # default to iframe template for sync embeddables
        embeddableItem.template = embeddableTemplates['iframe']

        @_addToRenderQueue(embeddableItem, $embeddableElement)
        # return null if sync!
        return

      , @)

      # exclude empty sync values from promises being returned out
      _.compact(promises)


    getEmbeddableItem: (embeddable, $embeddableElement) ->
      # clone embeddable for each embeddableItem to avoid bugs from referenced embeddable object embeddableTypes
      embeddableItem = _.clone(embeddable)

      linkPrefixedByMatchRegex = new RegExp(embeddableItem.match + '(.*)')
      embeddableItem.itemCode = $embeddableElement.attr(embeddableItem.matchAttr).match(linkPrefixedByMatchRegex)[1]
      embeddableItem.itemAPIUrl = embeddableItem.apiUrl()

      embeddableItem


    # builds and gets information needed for the render queue
    # returns promise with necessary embeddableItem data for template rendering
    # and embedding -- ready for adding to queue
    setHTMLFromAPI : (embeddableItem, $embeddableElement) ->

      selector = @_getEmbeddableSelector($embeddableElement)

      _addAPIDataToData = (data) ->
        embeddableItem.selector = selector

        if _.isFunction(embeddableItem.filterDataCallback)
          embeddableItem.filterDataCallback(data)

        embeddableItem.data = data
        embeddableItem

      request = $.get(embeddableItem.itemAPIUrl)
      request.then(_addAPIDataToData)


    # Gets a selector for render to find on @$el
    # Cannot use old $element from $temp because by the time the async HTML
    # gets rendered, $temp is irrelevant and it's html has been added to @$el
    _getEmbeddableSelector : ($element) ->
      # TODO: possible optimization
      # in the future, it would be nice to un-queue/elements that have matching selectors,
      # to prevent duplicate API calls
      matchAttr = if $element.attr('href') then 'href' else 'src'
      '.' + $element[0].className + '[' + matchAttr + '="' + $element.attr(matchAttr) + '"]'


    # Renders html through template and then adds embeddableItem to the queue for rendering
    _addToRenderQueue : (embeddableItem, $element) =>

      if $element
        toRender = {
          $el : $element,
          html : embeddableItem.template(embeddableItem)
        }
      else
        toRender = {
          selector : embeddableItem.selector,
          html : embeddableItem.template(embeddableItem)
        }

      @renderEmbeddableQueue.push(toRender)
      @renderEmbeddableQueue.trigger('add', toRender)

    ###
    # End embeddables logic
    ###

    fakeExercises: ($parent) ->
      sections = $parent.find('section[data-depth="1"]')

      appendFakeExercise = (section, iter) ->
        $(section).append(fakeExerciseTemplates[iter % fakeExerciseTemplates.length])

      _.each(sections, appendFakeExercise)


    onRender: () ->
      if not @model.asPage()?.get('active') then return

      # MathJax rendering must be done after the HTML has been added to the DOM
      MathJax?.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

      # Update the hash fragment after the content has loaded
      # to force the browser window to find the intended content
      jumpToHash = () =>
        if @model.asPage().get('loaded') and not @fragmentReloaded and window.location.hash
          @fragmentReloaded = true
          hash = window.location.hash
          window.location.hash = ''
          window.location.hash = hash

      $target = $(window.location.hash)
      if $target.prop('tagName')?.toLowerCase() is 'iframe'
        $target.on('load', jumpToHash)
      else
        jumpToHash()

    changePage: (e) ->
      # Don't intercept cmd/ctrl-clicks intended to open a link in a new tab
      return if e.metaKey or e.which isnt 1

      $el = $(e.currentTarget)
      href = $el.attr('href')

      if href?.indexOf("/contents/#{@model.getVersionedId()}:") is 0
        e.preventDefault()
        e.stopPropagation()

        @model.setPage($el.data('page'))

        router.navigate href, {trigger: false}, () => @parent.trackAnalytics()
        @parent.scrollToTop()

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution, [data-type="solution"]')
      $solution.toggleClass('ui-solution-visible')

    onEditable: () -> @$el.find('.media-body').addClass('draft')

    onUneditable: () ->
      @$el.find('.media-body').removeClass('draft')
      @render() # Re-render body view to cleanup aloha issues
