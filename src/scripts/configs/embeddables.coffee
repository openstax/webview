define (require) ->

  settings = require('settings')

  return {
    embeddableTypes: [{
      match: '#terp-'
      matchType: 'a'
      embeddableType: 'terp'
      apiUrl: () ->
        settings.terpUrl(@.itemCode)
    },{
      match: '#ost\/api\/ex\/'
      matchType: 'a'
      embeddableType: 'exercise'
      apiUrl: () ->
        settings.exerciseUrl(@.itemCode)

      # # Adds flexibility for if data needs transformation post API call
      # # For now, not needed for when using actual API.  Comment in if using local stub.
      # filterDataCallback: (data) ->

      #   data.items = _.filter(data.items, (item) ->
      #     _.indexOf(item.tags, @itemCode) > -1
      #   , @)

      onRender: ($parent) ->
        MATH_MARKER_INLINE = '\u200b\u200b\u200b'
        # For the maths.  you know. it do what it do.
        $mathElements = $parent.find('[data-math]:not(.math-rendered)')
        $mathElements.each (iter, element) ->
          formula = element.dataset.math
          element.textContent = "#{MATH_MARKER_INLINE}#{formula}#{MATH_MARKER_INLINE}"
          MathJax?.Hub.Queue(['Typeset', MathJax.Hub], element)
          MathJax?.Hub.Queue ->
            element.classList.add('math-rendered')

      async: true
    }]
  }
