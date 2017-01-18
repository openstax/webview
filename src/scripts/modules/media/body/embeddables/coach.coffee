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

    getAllPages: =>
      @parent.parent.parent.regions.sidebar.views[0].allPages

    findPageInAllPages: (findBy) =>
      allPages = @getAllPages()
      _.find allPages, findBy

    getPageNumberByUuid: (uuid) ->
      page = @findPageInAllPages (page) ->
        page.getUuid() is uuid
      page?.getPageNumber()

    getNextPageNumberFromUuid: (uuid) =>
      pageNumber = @getPageNumberByUuid(uuid)
      totalPages = @getAllPages().length

      if pageNumber < totalPages then ++pageNumber
      pageNumber

    updatePageFromCoach: ({collectionUUID, moduleUUID, pageNumber, link}) =>
      if @model.getUuid() is collectionUUID
        pageNumber = @getPageNumberByUuid(moduleUUID) if moduleUUID?
        pageNumber ?= 0
        return if pageNumber is @model.getPageNumber()

        href = linksHelper.getPath('contents', model: @model, page: pageNumber)
        return @parent.goToPage(pageNumber, href)

      router.navigate(link, {trigger: true})

    getNextPage: ({moduleUUID}) =>
      nextPageNumber = if moduleUUID?
        @getNextPageNumberFromUuid(moduleUUID)
      else
        @model.getNextPageNumber()
      nextPage = @findPageInAllPages (page) ->
        page.getPageNumber() is nextPageNumber

      return null unless nextPage?

      chapter = nextPage.get('chapter') or nextPage.get('_parent')?.get('chapter') or ''
      title = nextPage.get('searchTitle') or nextPage.get('title') or ''

      nextChapter: chapter
      nextTitle: title
      nextModuleUUID: nextPage.getUuid()

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
      enrollmentCode = query['enrollment_code']

      # nab math rendering from exercise embeddables config
      {onRender} = _.findWhere(embeddablesConfig.embeddableTypes, {embeddableType: 'exercise'})

      options =
        collectionUUID: @model.getUuid()
        moduleUUID: @model.get('currentPage')?.getUuid()
        getNextPage: @getNextPage
        cnxUrl: ''
        filterClick: @shouldClickPropagate
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

      if enrollmentCode?
        options.enrollmentCode = enrollmentCode

      _.clone(options)

    openCoach: (args...) =>
      options = @getOptionsForCoach()
      @cc.open(options, args...)
