define (require) ->

  settings = require('settings')

  return {
    embeddableTypes : [{
      match : '#terp-'
      matchType : 'a'
      embeddableType : 'terp'
      apiUrl : () ->
        settings.terpUrl(@.itemCode)
    },{
      match : '#ost\/api\/ex\/'
      matchType : 'a'
      embeddableType : 'exercise'
      apiUrl : () ->
        settings.exerciseUrl(@.itemCode)

      # # Adds flexibility for if data needs transformation post API call
      # # For now, not needed for when using actual API.  Comment in if using local stub.
      # filterDataCallback : (data) ->

      #   data.items = _.filter(data.items, (item) ->
      #     _.indexOf(item.tags, @itemCode) > -1
      #   , @)

      onRender : ($parent) ->
        # For the maths.  you know. it do what it do.
        $mathElements = $parent.find('[data-math]')
        $mathElements.each (iter, element) ->

          $element = $(element)
          formula = $element.data('math')

          mathTex = "[TEX_START]#{formula}[TEX_END]"
          $element.text(mathTex)

          # Moved adding to MathJax queue here. Means the queue gets pushed onto more (once per math element),
          # but what it trys to parse for matching math is WAY less than the whole page.
          MathJax?.Hub.Queue(['Typeset', MathJax.Hub], $element[0])

      async : true
    }]
  }