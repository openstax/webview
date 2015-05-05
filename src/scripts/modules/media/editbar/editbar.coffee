define (require) ->
  $ = require('jquery')
  BaseView = require('cs!helpers/backbone/views/base')
  PublishModal = require('cs!./modals/publish')
  BlockPublishModal = require('cs!./block-publish/modals/block-publish')
  template = require('hbs!./editbar-template')
  require('less!./editbar')
  require('bootstrapButton')
  require('bootstrapCollapse')
  require('bootstrapModal')

  blockDragHelper = $('''
    <div class="semantic-drag-helper aloha-ephemera">
        <div class="title"></div>
        <div class="body">Drag me to the desired location in the document</div>
    </div>
  ''')

  return class EditbarView extends BaseView
    template: template
    templateHelpers:
      changed: () -> @model.get('changed') or @model.get('childChanged')

    events:
      'click .save':    'save'
      'click .publish': 'publish'

    initialize: () ->
      super()
      @listenTo(@model, 'change:changed change:childChanged', @render)

    onRender: () ->
      super()
      @parent?.regions.self.append(new PublishModal({model: @model}))
      @parent?.regions.self.append(new BlockPublishModal({model: @model}))

      require ['aloha'], (Aloha) =>
        Aloha.ready () =>
          # setting up these drag sources may break if there is more than one top level editable on the page
          @$el.find('.semantic-drag-source').children().each (i, el) =>
            element = $(el)
            elementLabel = (element.data('type') or element.attr('class')).split(' ')[0]
            element.draggable
              connectToSortable: '.aloha-root-editable'
              appendTo: @$el
              revert: 'invalid'
              helper: ->
                helper = blockDragHelper.clone()
                helper.find('.title').text elementLabel
                helper

              start: (e, ui) ->
                $('.aloha-root-editable').addClass 'aloha-block-dropzone'
                $(ui.helper).addClass 'dragging'

              refreshPositions: true

    save: () ->
      @model.save()

    publish: () ->
      @model.isPublishable()
