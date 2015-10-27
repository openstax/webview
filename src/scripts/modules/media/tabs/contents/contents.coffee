define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  TocSectionView = require('cs!./toc/section')
  AddPopoverView = require('cs!./popovers/add/add')
  template = require('hbs!./contents-template')
  require('less!./contents')

  cumulativeChapters = []
  numberChapters = (toc, depth=0) ->
    sectionNumber = 0
    for item in toc
      isSection = not item.get('contents')?
      isCcap = (item.get('book')?.get('printStyle') ? '').match(/^ccap-/)?
      if isSection
        title = item.get('title')
        atTopLevel = depth == 0
        chapterNumber = cumulativeChapters[depth - 1]
        if not isCcap
          chapterNumber = cumulativeChapters.slice(0,depth).join('.')
          sectionNumber = cumulativeChapters[depth] ? 0
        if not (
          atTopLevel or
          isCcap and sectionNumber is 0 and title.match(/^Introduction/)
        )
          sectionNumber += 1
          cumulativeChapters[depth] = sectionNumber
          item.set('chapter', "#{chapterNumber}.#{sectionNumber}")
      else
        if cumulativeChapters[depth]?
          cumulativeChapters[depth] += 1
        else
          cumulativeChapters[depth] = 1
        contentsModels = item.get('contents')?.models
        if not isCcap
          cumulativeChapters[depth + 1] = 0
          chapterNumber = cumulativeChapters.slice(0,depth+1).join('.')
        else
          chapterNumber = cumulativeChapters[depth]
        numberChapters(contentsModels, depth+1) if contentsModels?
        item.set('chapter', chapterNumber)

  return class ContentsView extends BaseView
    template: template

    regions:
      toc: '.toc'

    events:
      'dragstart .toc [draggable]': 'onDragStart'
      'dragend .toc [draggable]': 'onDragEnd'

    initialize: () ->
      super()
      @listenTo(@model, 'change:editable removeNode moveNode add:contents', @render)
      cumulativeChapters = []
      numberChapters(@model.attributes.contents.models) if @model.attributes.contents?.models?

    onRender: () ->
      @regions.toc.show new TocSectionView
        model: @model

      @regions.self.append new AddPopoverView
        model: @model
        owner: @$el.find('.add.btn')

    onDragStart: (e) ->
      # Prevent children from interfering with drag events
      @$el.find('[draggable]').children().css('pointer-events', 'none')

    onDragEnd: (e) ->
      # Restore pointer events
      @$el.find('[draggable]').children().css('pointer-events', 'auto')

      # Reset styling for all draggable elements
      e.currentTarget.className = ''
