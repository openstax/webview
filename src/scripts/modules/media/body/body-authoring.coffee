
define (require) ->
  (MediaBodyViewBase) ->
    _ = require('underscore')

    return class MediaBodyViewWithAuthoring extends MediaBodyViewBase
      events: _.extend({}, MediaBodyViewBase.prototype.events, {
        'keydown .media-body': 'checkKeySequence'
        'keyup .media-body': 'resetKeySequence'
      })

      checkKeySequence: (e) ->
        key[e.keyCode] = true
        if @model.isDraft()
          #ctrl+alt+shift+p+i
          if key[16] and key[17] and key[18] and key[73] and key[80]
            instructionTags = []
            processingInstructions = @$el.find('.media-body').find('cnx-pi')

            _.each processingInstructions, (instruction) ->
              instructionTags.push(instruction.outerHTML)

            $('#pi').val(instructionTags.join('\n'))
            $('#processing-instructions-modal').modal('show')

      resetKeySequence: (e) ->
        key[e.keyCode] = false
