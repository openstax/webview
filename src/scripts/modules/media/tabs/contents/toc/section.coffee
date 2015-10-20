define (require) ->
  _ = require('underscore')
  TocDraggableView = require('cs!./draggable')
  TocPageView = require('cs!./page')
  SectionNameModal = require('cs!./modals/section-name/section-name')
  template = require('hbs!./section-template')
  require('less!./section')

  return class TocSectionView extends TocDraggableView
    template: template
    templateHelpers:
      editable: () -> @editable
    itemViewContainer: '> ul'

    events:
      'click > div > span > .section': 'toggleSection'
      'keydown > div > .section-wrapper': 'toggleSectionWithKeyboard'
      'click > div > .remove': 'removeNode'
      'click > div > .edit': 'editNode'

    initialize: () ->
      @content = @model.get('book') or @model
      @editable = @content.get('editable')
      @regions =
        container: @itemViewContainer
      @sectionNameModal = new SectionNameModal({model: @model})
      ###
      The TOC numbering solution below only applies to OpenStax books, which are
      identified by a print style starting with "ccao-"
      ###
      @isCcap = @content.get('printStyle')?.match(/^ccap-/i)

      super()

      @listenTo(@model, 'add change:unit change:title change:expanded sync:contents', @render)

    onRender: () ->
      super()

      @regions.container.empty()

      nodes = @model.get('contents')?.models

      _.each nodes, (node, idx) =>
        if node.isSection()
          @regions.container.appendAs 'li', new TocSectionView
            model: node
        else
          ###
          Do not number pages that are the first in their section and whose
          title begins with "Introduction"
          !!!
          This is an interim solution to the TOC numbering problem, which is
          probably imperfect.
          !!!
          ###
          if (@isCcap?)
            numbered = not(idx is 0 && node.get('title').match(/^Introduction/))
            if numbered == false
              node.set('numbered', false)
          @regions.container.appendAs 'li', new TocPageView
            model: node
            collection: @model

    toggleSection: (e) ->
      if @model.get('expanded')
        @model.set('expanded', false)
      else
        @model.set('expanded', true)

    toggleSectionWithKeyboard: (e) ->
      if e.keyCode is 13 or e.keyCode is 32
        e.preventDefault()
        @toggleSection(e)
        @$el.find('> div > .section-wrapper').focus()

    removeNode: () ->
      @content.removeNode(@model)

    editNode: () ->
      @regions.self.appendOnce
        view: @sectionNameModal
        as: 'div id="section-name-modal" class="modal fade"'
      @sectionNameModal.promptForValue(
        @model.attributes.title
        (newValue) =>
          @model.set('title', newValue)
          @model.set('changed', true)
          @model.get('book').set('childChanged', true)
          @model.get('book').set('changed', true))
      @sectionNameModal.$el.modal('show')
