
define (require) ->
  (MediaBodyViewBase, settings) ->

    return class MediaBodyWithCoachView extends MediaBodyViewBase
      regions:
        coach: '#coach-wrapper'

      isCoachInitialized: false

      hasCoach: ->
        @isCoachInitialized and @regions.coach.$el?

      getCoach: ->
        moduleUUID = @model.getUuid()?.split('?')[0]
        settings.conceptCoach?.uuids?[moduleUUID]

      isCoach: ->
        @getCoach()?

      hideExercises: ($el) ->
        hiddenClasses = @getCoach()
        hiddenSelectors = hiddenClasses.map((name) -> ".#{name}").join(', ')
        $exercisesToHide = $el.find(hiddenSelectors)
        $exercisesToHide.add($exercisesToHide.siblings('[data-type=title]')).hide()

        $exercisesToHide

      makeRegionForCoach: ($summary, wrapperId = 'coach-wrapper') ->
        $("##{wrapperId}").remove()
        $coachWrapper = $("<div id=\"#{wrapperId}\"></div>")
        $coachWrapper.insertAfter(_.last($summary))

      handleCoach: ($el) ->
        return unless @isCoach()
        @hideExercises($el)
        $summary = $el.find('section.summary[data-depth], section.section-summary[data-depth]')
        @makeRegionForCoach($summary) if $summary.length > 0

      onAfterSetupDom: ($temp) ->
        # Hide Exercises and set region for Concept Coach, only if canCoach
        @handleCoach($temp)

        super($temp)

      onAfterRender: ->
        # mount the Concept Coach if the mounter has been configured/if `isCoach`
        if @model.asPage()?.get('active') and @isCoach() and not @isCoachInitialized
          @initalizeCoach()
        super()

      initalizeCoach: ->
        @isCoachInitialized = true
        require(['cs!./embeddables/coach'], (Coach) =>
          unless @hasCoach()
            @regions.coach.append(new Coach({model: @model}))
        )

      queueForMathJax: ->
        super()?.Hub.Queue =>
          @processCoachMath?()
