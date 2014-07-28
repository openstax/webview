define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Mathjax = require('mathjax')
  EditableView = require('cs!helpers/backbone/views/editable')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends EditableView
    media: 'page'

    template: template
    templateHelpers:
      status: () -> @owner.get('status')

    editable:
      '.media-body':
        value: () -> 'content'
        type: 'aloha'

    events:
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

    onRender: () ->
      if not @model?.get('active') then return

      MathJax?.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

      # Converts a TERP link to an OST-hosted iframe
      @$el.find('a[href*="#terp-"]').each () ->
        terpCode = $(this).attr('href').match(/#terp\-(.*)/)[1]
        $(this).replaceWith("<iframe class='terp'
                                     src='https://stormy-wave-8747.herokuapp.com/terp/#{terpCode}/quiz_start'
                                     height='600px' width='800px' frameborder='0' seamless='seamless'>
                             </iframe>")

      # Remove the module title and abstract TODO: check if it is still necessary
      @$el.children('[data-type="title"]').remove()
      @$el.children('[data-type="abstract"]').remove()

      # Wrap title and content elements in header and section elements, respectively
      @$el.find('.example, .exercise, .note,
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
      @$el.find('.solution, [data-type="solution"]')
      .wrapInner('<section class="ui-body">')
      .prepend('''
        <div class="ui-toggle-wrapper">
          <button class="btn-link ui-toggle" title="Show/Hide Solution"></button>
        </div>''')


      @$el.find('figure:has(> figcaption)').addClass('ui-has-child-figcaption')

      # Move all figure captions below the figure
      @$el.find('figcaption').each (i, el) ->
        $(el).parent().append(el)

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution, [data-type="solution"]')
      $solution.toggleClass('ui-solution-visible')

    onEditable: () -> @$el.find('.media-body').addClass('draft')

    onUneditable: () ->
      @$el.find('.media-body').removeClass('draft')
      @render() # Re-render body view to cleanup aloha issues
