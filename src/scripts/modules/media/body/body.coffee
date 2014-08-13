define (require) ->
  $ = require('jquery')
  Mathjax = require('mathjax')
  router = require('cs!router')
  EditableView = require('cs!helpers/backbone/views/editable')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends EditableView
    media: 'page'

    template: template
    templateHelpers:
      status: () -> @owner.get('status')
      loaded: () ->
        if @model
          return @model.get('loaded')
        @owner.get('loaded')

    editable:
      '.media-body':
        value: () -> 'content'
        type: 'aloha'

    events:
      'click a': 'changePage'
      'click [data-type="solution"] > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'
      'click .solution              > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'

    initialize: () ->
      super()

      @owner = @model
      @setupModelListener()

    setupModelListener: () ->
      @stopListening()
      @model = @owner.asPage()

      @listenTo(@owner, 'change:currentPage', @updateModelListener)
      @listenTo(@model, 'change:active change:loaded', @updateModelListener) if @model

    updateModelListener: () ->
      @setupModelListener()
      @render()

    # Perform mutations to the HTML before loading it on to the page for better performance
    renderDom: () ->
      $temp = $('<div>').html(@getTemplate())

      if @owner.get('loaded') and @model?.get('loaded') and @model?.get('active')
        # Converts a TERP link to an OST-hosted iframe
        $temp.find('a[href*="#terp-"]').each () ->
          terpCode = $(this).attr('href').match(/#terp\-(.*)/)[1]
          $(this).replaceWith("<iframe class='terp'
                                       src='https://openstaxtutor.org/terp/#{terpCode}/quiz_start'
                                       height='600px' width='800px' frameborder='0' seamless='seamless'>
                               </iframe>")

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

        # Convert links to maintain context in a book, if appropriate
        $temp.find('a').each (i, el) =>
          $el = $(el)
          page = @owner.getPage($el.attr('href').substr(10))

          if page
            pageNumber = page.getPageNumber()
            $el.attr('href', "/contents/#{@owner.getVersionedId()}:#{pageNumber}")
            $el.attr('data-page', pageNumber)

        # Copy data-mark-prefix and -suffix from ol to li so they can be used in css
        $temp.find('ol[data-mark-prefix] > li, ol[data-mark-suffix] > li,
        .list[data-list-type="enumerated"][data-mark-prefix] > .item,
        .list[data-list-type="enumerated"][data-mark-suffix] > .item').each (i, el) ->
          $el = $(el)
          $parent = $el.parent()
          $el.attr('data-mark-prefix', $parent.data('mark-prefix'))
          $el.attr('data-mark-suffix', $parent.data('mark-suffix'))
        $temp.find('ol[start], .list[data-list-type="enumerated"][start]').each (i, el) ->
          $el = $(el)
          $el.css('counter-reset', 'list-item ' + $el.attr('start'))

      @$el?.html($temp.html())

    onRender: () ->
      if not @model?.get('active') then return

      # MathJax rendering must be done after the HTML has been added to the DOM
      MathJax?.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

    changePage: (e) ->
      $el = $(e.currentTarget)
      href = $el.attr('href')

      if href.indexOf("/contents/#{@owner.getVersionedId()}:") is 0
        e.preventDefault()
        e.stopPropagation()

        @owner.setPage($el.data('page'))

        router.navigate href, {trigger: false}, () => @parent.trackAnalytics()
        @parent.scrollToTop()

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution, [data-type="solution"]')
      $solution.toggleClass('ui-solution-visible')

    onEditable: () -> @$el.find('.media-body').addClass('draft')

    onUneditable: () ->
      @$el.find('.media-body').removeClass('draft')
      @render() # Re-render body view to cleanup aloha issues
