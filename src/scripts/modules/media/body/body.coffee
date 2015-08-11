
define (require) ->
  $ = require('jquery')
  embeddablesConfig = require('cs!configs/embeddables')
  Mathjax = require('mathjax')
  router = require('cs!router')
  linksHelper = require('cs!helpers/links')
  EditableView = require('cs!helpers/backbone/views/editable')
  ProcessingInstructionsModal = require('cs!./processing-instructions/modals/processing-instructions')
  SimModal = require('cs!./embeddables/modals/sims/sims')
  Coach = require('cs!./embeddables/coach')
  template = require('hbs!./body-template')
  settings = require('settings')
  require('less!./body')

  embeddableTemplates =
    'exercise': require('hbs!./embeddables/exercise-template')
    'iframe': require('hbs!./embeddables/iframe-template')

  return class MediaBodyView extends EditableView
    key = []
    media: 'page'
    template: template
    templateHelpers:
      editable: () -> @model.get('currentPage')?.isEditable()
      content: () -> @model.asPage()?.get('searchHtml') ? @model.asPage()?.get('content')
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
      'click [data-type="solution"] > .ui-toggle-wrapper > .ui-toggle,
        .solution > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'
      #'keydown .media-body': 'checkKeySequence'
      #'keyup .media-body': 'resetKeySequence'
      'click .os-interactive-link': 'simLink'

    regions:
      coach: '#coach-wrapper'

    initialize: () ->
      super()
      @jaxing = false
      @listenTo(@model, 'change:loaded', @render)
      @listenTo(@model, 'change:currentPage change:currentPage.active change:currentPage.loaded', @render)
      @listenTo(@model, 'change:currentPage.editable', @render)
      @listenTo(@model, 'change:currentPage.loaded change:currentPage.active change:shortId', @canonicalizePath)
      @listenTo(@model, 'change:currentPage.searchHtml', @render)

    canonicalizePath: =>
      if @model.isBook()
        currentPage = @model.get('currentPage')
        pageIsLoaded = currentPage?.get('loaded')
        return unless pageIsLoaded and currentPage.get('active')
        pageId = currentPage.getShortUuid()
      else
        pageId = 0
      currentRoute = Backbone.history.getFragment()
      canonicalPath = linksHelper.getPath('contents', {model: @model, page: pageId}, [])
      if (canonicalPath isnt "/#{currentRoute}")
        router.navigate(canonicalPath, {replace: true})

    updateTeacher: ($temp = @$el) ->
      $els = $temp.find('.os-teacher')

      if @model.get('teacher')
        $els.show()
      else
        $els.hide()

    goToPage: (pageNumber, href) ->
      @model.setPage(pageNumber)
      router.navigate href, {trigger: false}, => @parent.parent.parent.trackAnalytics()

    getCoach: ->
      moduleUUID = @model.getUuid()?.split('?')[0]
      settings.conceptCoach?.uuids?[moduleUUID]

    isCoach: ->
      @getCoach()?

    hideExercises: ($el) ->
      hiddenClasses = @getCoach()
      hiddenSelectors = hiddenClasses.map((name) -> ".#{name}").join(', ')
      $exercisesToHide = $el.find(hiddenSelectors)
      $exercisesToHide.add($exercisesToHide.siblings('[data-type=title]')).hide()

      $exercisesToHide

    makeRegionForCoach: ($summary, wrapperId = 'coach-wrapper') ->
      $("##{wrapperId}").remove()
      $coachWrapper = $("<div id=\"#{wrapperId}\"></div>")
      $coachWrapper.insertAfter(_.last($summary))

    handleCoach: ($el) ->
      return unless @isCoach()
      @hideExercises($el)
      $summary = $el.find('section.summary[data-depth], section.section-summary[data-depth]')
      @makeRegionForCoach($summary) if $summary.length > 0

    # Toggle the visibility of teacher's edition elements
    toggleTeacher: () ->
      @model.set('teacher', not @model.get('teacher'))
      @updateTeacher()

    # Perform mutations to the HTML before loading it on to the page for better performance
    renderDom: () ->
      $temp = $('<div>').html(@getTemplate())

      try
        if @model.get('loaded') and @model.asPage()?.get('loaded') and @model.asPage()?.get('active')

          # Add an attribute marking that this is collated
          # TODO: Move this into the handlebars template
          isCollated = @model.asPage().isCollated()
          $temp.find('#content').attr('data-is-baked', isCollated)

          if $temp.find('.os-interactive-link').length
            @model.set('sims', true)

          $temp.find('table th').attr('scope', 'col')

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
          $temp.find('.exercise .solution, [data-type="exercise"] [data-type="solution"]')
          .wrapInner('<section class="ui-body">')
          .prepend('''
            <div class="ui-toggle-wrapper">
              <button class="btn-link ui-toggle" title="Show/Hide Solution"></button>
            </div>''')

          $temp.find('figure:has(> figcaption)').addClass('ui-has-child-figcaption')

          # Move all figure captions below the figure
          $temp.find('figcaption').each (i, el) ->
            $(el).parent().append(el)

          # Convert figure, table, exercise, problem and note links to show the proper name
          $temp.find('a[href^="#"]:not([data-type=footnote-number]):not([data-type=footnote-ref])').each (i, el) ->
            $el = $(el)
            href = $el.attr('href')

            if href.length > 1
              try
                $target = $temp.find(href)

                tag = $target?.prop('tagName')?.toLowerCase()

                if $target?.attr('data-type') isnt undefined
                  tag = $target?.attr('data-type')?.toLowerCase()

                if $el.text() is '[link]' and tag
                  tag = tag.charAt(0).toUpperCase() + tag.substring(1)
                  $el.text("#{tag}") if tag isnt 'undefined'

          # Convert links to maintain context in a book, if appropriate
          if @model.isBook()
            $temp.find('a:not([data-type=footnote-number]):not([href^="#"])').each (i, el) =>
              $el = $(el)
              href = $el.attr('href')

              [href, fragment] = href.split('#')
              page = @model.getPage(href.substr(10))
              fragment = fragment and "##{fragment}" or ''

              if page
                pageNumber = page.getPageNumber()
                $el.attr('href', "/contents/#{@model.getVersionedId()}:#{page.id}#{fragment}")
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

          # Hide Exercises and set region for Concept Coach, only if canCoach
          @handleCoach($temp)

          @initializeEmbeddableQueues()
          @findEmbeddables($temp.find('#content'))

          # Show Teacher's Edition content if appropriate
          @updateTeacher($temp)

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
      # @renderEmbeddableQueue?.on('message', (message)->)
      #
      # # Not needed at the moment.
      # # Post render again when all promises have returned
      # @renderEmbeddableQueue?.on('done', @onRender.bind(@))

    renderEmbeddable: (embeddableItem) =>
      # finds fresh element in @$el if a selector is provided
      # instead of the element itself.

      embeddableItem.$el = @$el.find(embeddableItem.selector) if embeddableItem.selector

      $parent = embeddableItem.$el.parent()
      if $parent.prop('tagName')?.toLowerCase() is 'p'
        $parent.replaceWith(embeddableItem.html)
      else
        embeddableItem.$el.replaceWith(embeddableItem.html)

      embeddableItem.onRender?($parent)


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
      $elementsToFilter =
        a: $parent.find('a'),
        iframe: $parent.find('iframe')

      # Add embeddable types as needed in embeddablesConfig
      embeddableTypes = embeddablesConfig.embeddableTypes

      # process each embeddable type
      _.each embeddableTypes, (embeddable) ->

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

      , @

      embeddablePromises = _.flatten(embeddablePromises)
      # tell the queue when async embeddables have been all been added!
      $.when.apply(@, embeddablePromises).then(() =>
        @renderEmbeddableQueue.trigger('message', 'async embeddables added to queue')
        @renderEmbeddableQueue.trigger('done')
      )

    # where the magic happens
    addEmbeddablesToRenderQueue: (embeddable, $embeddables) =>

      # map to track result from adding each embeddable to the queue
      promises = _.map $embeddables, (embeddableElement) ->

        $embeddableElement = $(embeddableElement)
        embeddableItem = @getEmbeddableItem(embeddable, $embeddableElement)

        # if the embeddable is async, it needs to do an external call
        # to get information to feed to the template for the embeddableType
        if embeddableItem.async
          embeddableItem.template = embeddableTemplates[embeddableItem.embeddableType]
          # returns promise for AJAX call and adds to render queue
          # with data from AJAX call
          return @setHTMLFromAPI(embeddableItem).then(@_addToRenderQueue)

        # default to iframe template for sync embeddables
        embeddableItem.template = embeddableTemplates['iframe']

        @_addToRenderQueue(embeddableItem)
        # return null if sync!
        return

      , @

      # exclude empty sync values from promises being returned out
      _.compact(promises)


    getEmbeddableItem: (embeddable, $embeddableElement) ->
      # clone embeddable for each embeddableItem to avoid bugs from referenced embeddable object embeddableTypes
      embeddableItem = _.clone(embeddable)

      linkPrefixedByMatchRegex = new RegExp(embeddableItem.match + '(.*)')
      embeddableItem.itemCode = $embeddableElement.attr(embeddableItem.matchAttr).match(linkPrefixedByMatchRegex)[1]
      embeddableItem.itemAPIUrl = embeddableItem.apiUrl()
      embeddableItem.$el = $embeddableElement

      embeddableItem


    # builds and gets information needed for the render queue
    # returns promise with necessary embeddableItem data for template rendering
    # and embedding -- ready for adding to queue
    setHTMLFromAPI: (embeddableItem) ->

      embeddableItem.selector = @_getEmbeddableSelector(embeddableItem.$el)
      delete embeddableItem.$el

      _addAPIDataToData = (data) ->
        embeddableItem.filterDataCallback?(data)

        embeddableItem.data = data
        embeddableItem

      request = $.get(embeddableItem.itemAPIUrl)
      request.then(_addAPIDataToData)


    # Gets a selector for render to find on @$el
    # Cannot use old $element from $temp because by the time the async HTML
    # gets rendered, $temp is irrelevant and it's html has been added to @$el
    _getEmbeddableSelector: ($element) ->
      # TODO: possible optimization
      # in the future, it would be nice to un-queue/elements that have matching selectors,
      # to prevent duplicate API calls
      matchAttr = if $element.attr('href') then 'href' else 'src'

      classString = if $element[0].className then '.' + $element[0].className else ''
      elementNameString  = $element[0].tagName.toLowerCase()
      matchAttrString = '[' + matchAttr + '="' + $element.attr(matchAttr) + '"]'

      elementNameString + classString + matchAttrString


    # Renders html through template and then adds embeddableItem to the queue for rendering
    _addToRenderQueue: (embeddableItem) =>

      embeddableItem.html = embeddableItem.template(embeddableItem)

      @renderEmbeddableQueue.push(embeddableItem)
      @renderEmbeddableQueue.trigger('add', embeddableItem)

    ###
    # End embeddables logic
    ###

    fakeExercises: ($parent) ->
      return
      #sections = $parent.find('section[data-depth="1"]')

      #appendFakeExercise = (section, iter) ->
      #  $(section).append(fakeExerciseTemplates[iter % fakeExerciseTemplates.length])

      #_.each(sections, appendFakeExercise)

    onRender: () ->
      @trigger('render')
      currentPage = @model.asPage()
      return unless currentPage?
      page = currentPage ? @model.get('contents')?.models[0]?.get('book')
      #if @model.asPage()?.get('loaded') and @model.isDraft()
      #  @parent?.regions.self.append(new ProcessingInstructionsModal({model: @model}))

      return unless currentPage.get('active')
      if @model.get('sims') is true
        @parent?.regions.self.append(new SimModal({model: @model}))

      # mount the Concept Coach if the mounter has been configured/if `canCoach`
      if @isCoach()
        @coach = new Coach({model: @model})
        @regions.coach.append(@coach)

      # MathJax rendering must be done after the HTML has been added to the DOM
      MathJax?.Hub.Queue =>
        @jaxing = true
      MathJax?.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))
      MathJax?.Hub.Queue =>
        @jaxing = false
        @processCoachMath?()

      # Update the hash fragment after the content has loaded
      # to force the browser window to find the intended content
      jumpToHash = () =>
        if currentPage.get('loaded') and not @fragmentReloaded and window.location.hash
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
        @goToPage($el.data('page'), href)

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution, [data-type="solution"]')
      $solution.toggleClass('ui-solution-visible')

    onEditable: () -> @$el.find('.media-body').addClass('draft')

    onUneditable: () ->
      @$el.find('.media-body').removeClass('draft')
      @render() # Re-render body view to cleanup aloha issues

    checkKeySequence: (e) ->
      return
      #key[e.keyCode] = true
      #if @model.isDraft()
        #ctrl+alt+shift+p+i
      #  if key[16] and key[17] and key[18] and key[73] and key[80]
      #    instructionTags = []
      #    processingInstructions = @$el.find('.media-body').find('cnx-pi')

      #    _.each processingInstructions, (instruction) ->
      #      instructionTags.push(instruction.outerHTML)

      #    $('#pi').val(instructionTags.join('\n'))
      #    $('#processing-instructions-modal').modal('show')

    resetKeySequence: (e) ->
      return
      #key[e.keyCode] = false

    simLink: (evt) ->
      evt.preventDefault()
      link = $(evt.currentTarget)
      @model.set('simUrl', link.attr('href'))
      @model.set('simTitle', link.parents('figure').find('[data-type="title"]').text())
      $('#sims-modal').modal('show')
