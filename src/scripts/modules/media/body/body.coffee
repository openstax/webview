
define (require) ->
  $ = require('jquery')
  _ = require('underscore')

  embeddablesConfig = require('cs!configs/embeddables')
  Mathjax = require('mathjax')
  router = require('cs!router')
  linksHelper = require('cs!helpers/links')
  EditableView = require('cs!helpers/backbone/views/editable')
  ProcessingInstructionsModal = require('cs!./processing-instructions/modals/processing-instructions')
  ContentsView = require('cs!modules/media/tabs/contents/contents')
  SimModal = require('cs!./embeddables/modals/sims/sims')
  FeaturedBook = require('cs!models/featured-openstax-book')
  template = require('hbs!./body-template')
  settings = require('settings')
  analytics = require('cs!helpers/handlers/analytics')
  require('less!./body')

  embeddableTemplates =
    'exercise': require('hbs!./embeddables/exercise-template')
    'iframe': require('hbs!./embeddables/iframe-template')

  return class MediaBodyView extends EditableView
    key = []
    media: 'page'
    template: template
    templateHelpers:
      about: () -> @featuredBookModel.toJSON()
      hasAbout: () -> @shouldDisplayAbout()
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

    regions:
      media: '.media-body'
      about: '.media-body-about'

    events:
      'click a': 'changePage'
      'click [data-type="solution"] > .ui-toggle-wrapper > .ui-toggle,
        .solution > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'

      'click .os-interactive-link': 'simLink'
      'mousedown .os-table' : 'startSwiping'
      'mouseup .os-table' : 'stopSwiping'
      'mouseleave .os-table' : 'stopSwiping'
      'mousemove .os-table' : 'handleSwipe'

    shouldDisplayAbout: () ->
      @model.get('currentPage')?.getPageNumber() == @model.defaultPage()

    initialize: () ->
      super()
      @jaxing = false

      @featuredBookModel = new FeaturedBook()
      @listenTo(@featuredBookModel, 'change', @render)

      @listenTo(@model, 'change:loaded', @render)
      @listenTo(@model, 'change:loaded', () ->
        @featuredBookModel.set({cnx_id: @model.id}).fetch()
      )
      @listenTo(@model, 'change:currentPage change:currentPage.active change:currentPage.loaded', @render)
      @listenTo(@model, 'change:currentPage.editable', @render)
      @listenTo(@model, 'change:currentPage.loaded change:currentPage.active change:shortId', @canonicalizePath)
      @listenTo(@model, 'change:currentPage.searchHtml', @render)

    canonicalizePath: =>
      allTrackers = [settings.analyticsID]
      if @model.get('googleAnalytics')
        allTrackers = allTrackers.concat(@model.get('googleAnalytics'))

      if @model.isBook()
        currentPage = @model.get('currentPage')
        pageIsLoaded = currentPage?.get('loaded')
        return unless pageIsLoaded and currentPage.get('active')
        pageId = currentPage.getShortUuid()
        if currentPage.get('googleAnalytics')
          allTrackers = allTrackers.concat(currentPage.get('googleAnalytics'))
      else
        pageId = 0
      currentRoute = Backbone.history.getFragment()
      canonicalPath = linksHelper.getPath('contents', {model: @model, page: pageId}, []) + window.location.hash
      if (canonicalPath isnt "/#{currentRoute}")
        # replace previous URL with the canonical path
        # Set analytics:false to prevent double-tracking pageViews.
        # It's not ideal, because it does not track the canonical version that a person saw
        # See #1601
        router.navigate(canonicalPath, {replace: true, analytics: false})
      # Only send analytics once the canonical URL is in the browser URL
      analytics.sendAnalytics(_.uniq(allTrackers))


    updateTeacher: ($temp = @$el) ->
      $els = $temp.find('.os-teacher')

      if @model.get('teacher')
        $els.show()
      else
        $els.hide()

    supportPreviousVersionOfFootnoteS: ($temp) ->
      $footnotes = $temp.find('[role=doc-footnote]')

      if $footnotes.length
        $header = document.createElement('h3')
        $header.setAttribute('data-type', 'footnote-refs-title')
        $header.setAttribute('data-l10n-id', 'textbook-view-footnotes')

        $container = document.createElement('div')
        $container.setAttribute('data-type', 'footnote-refs')
        $container.appendChild($header)

        $list = document.createElement('ul')
        $list.setAttribute('data-list-type', 'bulleted')
        $list.setAttribute('data-bullet-style', 'none')

        $index = 0
        while $index < $footnotes.length
          $footnote = $footnotes[$index]

          $counter = $index + 1

          $item = document.createElement('li')
          $item.setAttribute('id', $footnote.getAttribute('id'))
          $item.setAttribute('data-type', 'footnote-ref')

          $anchor = document.createElement('a')
          $anchor.setAttribute('data-type', 'footnote-ref-link')
          $anchor.setAttribute('href', '#footnote-ref' + $counter)
          $anchor.innerHTML = $counter

          $content = document.createElement('span')
          $content.setAttribute('data-type', 'footnote-ref-content')
          $content.innerHTML = " " + $footnote.innerHTML

          $number = $content.querySelector('[data-type="footnote-number"]')
          if $number
            $number.remove()

          $item.appendChild($anchor)
          $item.appendChild($content)

          $list.appendChild($item)
          $footnote.remove()

          $index++

        $container.appendChild($list)
        $rootEl = $temp.find('#content')
        $rootEl.append($container)
        $footnoteLinks = $temp.find('[role="doc-noteref"]')

        index = 0
        while index < $footnoteLinks.length
          $link = $footnoteLinks[index]

          $counter = index + 1

          $sup = document.createElement('sup')
          $sup.setAttribute('id', 'footnote-ref' + $counter)
          $sup.setAttribute('data-type', 'footnote-number')

          $link.setAttribute('data-type', 'footnote-link')

          $link.replaceWith($sup)
          $sup.appendChild($link)

          index++

    goToPage: (pageNumber, href) ->
      @model.setPage(pageNumber)

      router.navigate(href, {trigger: true, replace: false}, => @parent.parent.parent.trackAnalytics())

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
          $('#main-content').attr('data-is-baked', isCollated)

          if $temp.find('.os-interactive-link').length
            @model.set('sims', true)

          $temp.find('table th').attr('scope', 'col')

          # Remove the module title and abstract TODO: check if it is still necessary
          $temp.children('[data-type="title"]').remove()
          $temp.children('[data-type="abstract"]').remove()

          # Wrap title and content elements in header and section elements, respectively
          $temp.find('.example, .exercise, .note, .abstract,
                    [data-type="example"], [data-type="exercise"],
                    [data-type="note"], [data-type="abstract"]').each (index, el) ->
            $el = $(el)
            $contents = $el.contents().filter (i, node) ->
              return !$(node).is('.title, [data-type="title"], .os-title')
            $contents.wrapAll('<section>')
            $title = $el.children('.title, [data-type="title"], .os-title')
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
          .wrapInner('<section class="ui-body" role="alert">')
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

          @initializeEmbeddableQueues()
          @findEmbeddables($temp.find('#content'))

          # Show Teacher's Edition content if appropriate
          @updateTeacher($temp)

          @supportPreviousVersionOfFootnoteS($temp)

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


    onRender: () ->
      @trigger('render')
      currentPage = @model.asPage()
      return unless currentPage?
      page = currentPage ? @model.get('contents')?.models[0]?.get('book')

      return unless currentPage.get('active')
      if @model.get('sims') is true
        @parent?.regions.self.append(new SimModal({model: @model}))

      # MathJax rendering must be done after the HTML has been added to the DOM
      MathJax?.Hub.Queue =>
        @jaxing = true
      MathJax?.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))
      MathJax?.Hub.Queue =>
        @jaxing = false

      # Clear and replace the hash fragment after the content has loaded
      # to force the browser window to find the intended content (as a side effect)
      jumpToHash = () ->
        if currentPage.get('loaded') and window.location.hash
          linksHelper.offsetHash()

      $target = $(window.location.hash)
      if $target.prop('tagName')?.toLowerCase() is 'iframe'
        $target.on('load', jumpToHash)
      else
        jumpToHash()

      @regions.about.append(new ContentsView({model: @model, static: true}))

      # Wrap tables inside unbaked books with additional div so we can
      # apply overflow-x: auto to them. Tables inside baked books are wrapped with .os-table
      if !@model.asPage().isCollated()
        $('.main-page table').each (index, table) ->
          $(table).wrap('<div class="table-wrapper"></div>')

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
      $uiBody = $solution[0].getElementsByClassName('ui-body')[0]
      $uiBodyLive = $solution[0].getElementsByClassName('ui-body-live')[0]
      if $solution.hasClass('ui-solution-visible')
        $solution.attr('aria-expanded',true)
        $solution.attr('aria-label',"hide solution")
      else
        $solution.attr('aria-expanded',false)
        $solution.attr('aria-label',"show solution")
    onEditable: () -> @$el.find('.media-body').addClass('draft')

    onUneditable: () ->
      @$el.find('.media-body').removeClass('draft')
      @render() # Re-render body view to cleanup aloha issues

    checkKeySequence: (e) ->
      return

    resetKeySequence: (e) ->
      return


    simLink: (evt) ->
      evt.preventDefault()
      link = $(evt.currentTarget)
      @model.set('simUrl', link.attr('href'))
      @model.set('simTitle', link.parents('figure').find('[data-type="title"]').text())
      $('#sims-modal').modal('show')

    # Handle Big Tables - add swiping | Proper events are added at the top of the file

    isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
    isSwiping = false
    tableLeftPos = 0
    startSwipingPos = 0
    swipeRange = 0

    isSwipable: (target) ->
      if !@isMobile and target.offsetWidth < target.getElementsByTagName('table')[0].offsetWidth
        return true
      false

    handleSwipe: (e) ->
      target = e.currentTarget
      if @isSwipable(target)
        if !target.classList.contains('swipe-table') then target.classList.add('swipe-table')
      if @isSwiping
        mouseX = e.clientX
        swipeDistance = @startSwipingPos - mouseX
        if swipeDistance <= @swipeRange and swipeDistance >= -1 * @swipeRange
          target.scrollLeft += swipeDistance
      return

    startSwiping: (e) ->
      target = e.currentTarget
      if @isSwipable(target)
        @isSwiping = true
        offsets = target.getBoundingClientRect()
        @tableLeftPos = offsets.left
        @startSwipingPos = window.event.clientX
        @swipeRange = target.getElementsByTagName('table')[0].offsetWidth - (target.offsetWidth)
      return

    stopSwiping: () ->
      @isSwiping = false
      return

    # End big tables
