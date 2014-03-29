define (require) ->
  $ = require('jquery')
  # Mathjax = require('mathjax')
  EditableView = require('cs!helpers/backbone/views/editable')
  template = require('hbs!./body-template')
  require('less!./body')

  return class MediaBodyView extends EditableView
    template: template
    templateHelpers:
      loaded: () ->
        if @model.isBook()
          return @model.get('loaded') and
            (@model.get('currentPage')?.get('loaded') or @model.get('contents')?.length is 0)

        return @model.get('loaded')

      content: () ->
        if @model.isBook()
          return @model.get('currentPage.content')

        return @model.get('content')

      isDraft: () ->
        if @model.isBook()
          version = @model.get('currentPage.version')
        else
          version = @model.get('version')
        return 'draft' == version or true # No version means it is a draft

    editable:
      '.media-body':
        value: () -> @getModel('content')
        type: 'aloha'

    events:
      'click .solution > .ui-toggle-wrapper > .ui-toggle': 'toggleSolution'

    initialize: () ->
      super()
      @listenTo(@model, 'changePage change:loaded change:currentPage.loaded', @render)

    onRender: () ->
      # MathJax.Hub.Queue(['Typeset', MathJax.Hub], @$el.get(0))
      # Wrap title and content elements in header and section elements, respectively
      @$el.find('.example, .exercise, .note').each (index, el) ->
        $el = $(el)
        $contents = $el.contents().filter (i, node) ->
          return !$(node).hasClass('title')
        $contents.wrapAll('<section>')
        $title = $el.children('.title')
        # Add an attribute for the parents' `data-label`
        # since CSS does not support `parent(attr(data-label))`.
        # When the title exists, this attribute is added before it
        $title.attr('data-label-parent', $el.attr('data-label'))
        # Add a class for styling since CSS does not support `:has(> .title)`
        # NOTE: `.toggleClass()` explicitly requires a `false` (not falsy) 2nd argument
        $el.toggleClass('ui-has-child-title', $title.length > 0)


      # Wrap solutions in a div so "Show/Hide Solutions" work
      @$el.find('.solution')
      .wrapInner('<section class="ui-body">')
      .prepend('''
        <div class="ui-toggle-wrapper">
          <button class="btn-link ui-toggle" title="Show/Hide Solution"></button>
        </div>''')

    toggleSolution: (e) ->
      $solution = $(e.currentTarget).closest('.solution')
      $solution.toggleClass('ui-solution-visible')
