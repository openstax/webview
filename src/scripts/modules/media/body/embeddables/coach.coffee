define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  linksHelper = require('cs!helpers/links')
  router = require('cs!router')
  settings = require('settings')

  ConceptCoachAPI = require('OpenStaxConceptCoach')
  embeddablesConfig = require('cs!configs/embeddables')

  return class Coach extends BaseView
    initialize: ->
      return unless @isCoach()
      $body = $('body')
      @cc = new ConceptCoachAPI(settings.conceptCoach.url)

      @cc.on('ui.launching', @openCoach)
      @cc.on('ui.close', _.partial(@cc.handleClosed, _, $body[0]))
      @cc.on('open', _.partial(@cc.handleOpened, _, $body[0]))
      @cc.on('book.update', @updatePageFromCoach)
      @cc.on('book.continue', @updatePageNext)
      @cc.on 'view.update', (eventData) =>
        {newPath, options} = @getPathForCoach(eventData)
        router.navigate(newPath, options) if newPath?

      @listenTo(@model, 'change:currentPage', @updateCoachOptions)

    onRender: ->
      return unless @$el[0]?
      coachOptions = @getOptionsForCoach()
      @cc.initialize(@$el[0], coachOptions)

    onBeforeClose: ->
      if @cc?
        @cc.destroy?()
        delete @cc

    getCoach: ->
      moduleUUID = @model.getUuid()?.split('?')[0]
      settings.conceptCoach?.uuids?[moduleUUID]
    isCoach: ->
      @getCoach()?
    canCoach: ->
      @isCoach() and @cc?

    hideExercises: ($el) ->
      hiddenClasses = @getCoach()
      hiddenSelectors = hiddenClasses.map((name) -> ".#{name}").join(', ')
      $exercisesToHide = $el.find(hiddenSelectors)
      $exercisesToHide.add($exercisesToHide.siblings('[data-type=title]')).hide()

      $exercisesToHide

    handleCoach: ($el) ->
      return unless @canCoach()
      $hiddenExercises = @hideExercises($el)

    updateCoachOptions: ->
      options = @getOptionsForCoach()
      @cc.setOptions(options)

    findPageInAllPages: (findBy) =>
      {allPages} = @parent.parent.parent.regions.sidebar.views[0]
      _.find allPages, findBy

    getPageNumberByUuid: (uuid) ->
      page = @findPageInAllPages (page) ->
        page.getUuid() is uuid

      page?.getPageNumber()

    updatePageFromCoach: ({collectionUUID, moduleUUID, pageNumber, link}) =>
      if @model.getUuid() is collectionUUID
        pageNumber = @getPageNumberByUuid(moduleUUID) if moduleUUID?
        pageNumber ?= 0
        return if pageNumber is @model.getPageNumber()

        href = linksHelper.getPath('contents', model: @model, page: pageNumber)
        return @parent.goToPage(pageNumber, href)

      router.navigate(link, {trigger: true})

    updatePageNext: ({collectionUUID}) =>
      pageNumber = @model.getNextPageNumber()
      @updatePageFromCoach({collectionUUID, pageNumber})

    getNextPageLabel: ->
      nextPageNumber = @model.getNextPageNumber()
      nextPage = @findPageInAllPages (page) ->
        page.getPageNumber() is nextPageNumber

      return "" unless nextPage?
      "#{nextPage.get('chapter')} #{nextPage.get('searchTitle') or nextPage.get('title')}"

    getPathForCoach: (coachData) ->
      return unless coachData?.route?
      {path, query} = linksHelper.getCurrentPathComponents()
      options =
        trigger: false

      if query['cc-view'] isnt coachData.state.view
        newQuery = _.extend({}, query, 'cc-view': coachData.state.view)
        pathFragments = [path.split('?')[0]]

        if coachData.state.view is 'close'
          delete newQuery['cc-view']
        else if query['cc-view']?
          options.replace = true

        if not _.isEmpty(newQuery)
          pathFragments.push(linksHelper.param(newQuery))

        newPath = pathFragments.join('?')

      {newPath, options}

    getOptionsForCoach: ->
      {query} = linksHelper.getCurrentPathComponents()
      view = query['cc-view']

      # nab math rendering from exercise embeddables config
      {onRender} = _.findWhere(embeddablesConfig.embeddableTypes, {embeddableType: 'exercise'})

      options =
        collectionUUID: @model.getUuid()
        moduleUUID: @model.get('currentPage')?.getUuid()
        nextPage: @getNextPageLabel()
        cnxUrl: ''
        processHtmlAndMath: (root) =>
          # If the main body's MathJax is still processing,
          # queueing up additional elements freezes the main body's
          # MathJax and prevents the coach's MathJax from ever processing.
          #
          # This will que up the coach's MathJax-ing if the main jaxing is
          # in progress, and will run the coach's MathJax-ing immediately
          # otherwise.
          if @parent.jaxing
            return unless @cc.component?.props?.open
            toRender = @parent.processCoachMath
            @parent.processCoachMath = ->
              toRender?()
              onRender($(root))
          else
            onRender($(root))
          true

      if view?
        options.view = view
        options.open = true

      _.clone(options)

    openCoach: =>
      options = @getOptionsForCoach()
      @cc.open(options)
