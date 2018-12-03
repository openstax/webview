define (require) ->

  settings = require('json!settings.json')
  exercisesport = if settings.exercises.port then ":#{settings.exercises.port}" else ''
  exercises = "#{location.protocol}//#{settings.exercises.host}#{exercisesport}"
  renderMath = ($parent) ->
    # We use some invisible spaces as the math markers because they are more reliable than $
    MATH_MARKER_INLINE = '\u200b\u200b\u200b'
    # For the maths.  you know. it do what it do.
    $mathElements = $parent.find('[data-math]:not(.math-rendered)')
    $mathElements.each (iter, element) ->
      formula = element.dataset.math
      element.textContent = "#{MATH_MARKER_INLINE}#{formula}#{MATH_MARKER_INLINE}"
      MathJax?.Hub.Queue(['Typeset', MathJax.Hub], element)
      MathJax?.Hub.Queue ->
        element.classList.add('math-rendered')

  return {
    embeddableTypes: [
      {
        match: '#ost/api/ex/'
        matchType: 'a'
        embeddableType: 'exercise'
        apiUrl: () ->
          "#{exercises}/api/exercises?q=tag:\"#{encodeURIComponent(@itemCode)}\""

        # # Adds flexibility for if data needs transformation post API call
        # # For now, not needed for when using actual API.  Comment in if using local stub.
        # filterDataCallback: (data) ->

        #   data.items = _.filter(data.items, (item) ->
        #     _.indexOf(item.tags, @itemCode) > -1
        #   , @)

        onRender: renderMath

        async: true
      },
      {
        match: '#exercises?/'
        matchType: 'a'
        embeddableType: 'exercise'
        apiUrl: () ->
          "#{exercises}/api/exercises?q=nickname:\"#{encodeURIComponent(@itemCode)}\""

        # # Adds flexibility for if data needs transformation post API call
        # # For now, not needed for when using actual API.  Comment in if using local stub.
        # filterDataCallback: (data) ->

        #   data.items = _.filter(data.items, (item) ->
        #     _.indexOf(item.tags, @itemCode) > -1
        #   , @)

        onRender: renderMath

        async: true
      }
    ]
  }
