
define (require) ->
  (MediaBodyViewBase, settings) ->
    coachMixin = require('cs!helpers/backbone/views/coach-mixin')

    return class MediaBodyWithCoachView extends MediaBodyViewBase.extend(coachMixin)
      regions:
        coach: '#coach-wrapper'

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
        # mount the Concept Coach if the mounter has been configured/if `canCoach`
        if @model.asPage()?.get('active') and not @hasCoach() and @isCoach()
          require(['cs!./embeddables/coach'], @mountCoach)
        super()

      mountCoach: (Coach) =>
        @regions.coach.append(new Coach({model: @model})) unless @hasCoach()
        @trigger('change:coachMounted')

      queueForMathJax: ->
        super()?.Hub.Queue =>
          @processCoachMath?()
