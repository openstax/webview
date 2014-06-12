define (require) ->
  $ = require('jquery')
  _ = require('underscore')
  Mathjax = require('mathjax')
  EditableView = require('cs!helpers/backbone/views/editable')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends EditableView
    template: template
    templateHelpers:
      loaded: () ->
        if @model.isBook()
          return @model.get('loaded') and
            (@model.asPage()?.get('loaded') or @model.get('contents')?.length is 0)

        return @model.get('loaded')

      content: () ->
        page = @model.asPage()
        return page?.get('content')

      hasContent: () ->
        return (_.isString(@model.get('content')) or _.isString(@model.get('currentPage.content')))

      editable: () -> @isEditable()

    editable:
      '.media-body':
        value: () -> @getModel('content')
        type: 'aloha'

    events:
      'click [data-type="solution"] > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'
      'click .solution              > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'

    initialize: () ->
      super()
      @listenTo(@model, 'changePage change:loaded change:currentPage.loaded', @render)
      @listenTo(@model, 'change:editable', @toggleDraftMode)

    onRender: () ->
      MathJax?.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))

      # Remove the module title and abstract TODO: check if it is still necessary
      @$el.children('[data-type="title"]').remove()
      @$el.children('[data-type="abstract"]').remove()

      # Wrap title and content elements in header and section elements, respectively
      @$el.find('.example, .exercise, .note, [data-type="example"], [data-type="exercise"], [data-type="note"]').each (index, el) ->
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

    isEditable: () ->
      if @model.isBook()
        return @model.get('currentPage')?.isEditable()

      return @model.isEditable()

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution, [data-type="solution"]')
      $solution.toggleClass('ui-solution-visible')

    toggleDraftMode: () ->
      if @model.get('editable')
        @$el.find('.media-body').addClass('draft')
      else
        @$el.find('.media-body').removeClass('draft')
        @render() # Re-render body view to cleanup aloha issues
