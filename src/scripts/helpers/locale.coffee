define (require) ->
  return new class Localizer

    currentView = null
    HTMLNode = document.querySelector('html')
    defaultLocale = HTMLNode.getAttribute('lang') || 'en-US'

    # Detect support for  MutationObserver.
    MutationObserver = do ->
      prefixes = ['WebKit', 'Moz', 'O', 'Ms', '', ]
      i = 0
      while i < prefixes.length
        if prefixes[i] + 'MutationObserver' of window
          return window[prefixes[i] + 'MutationObserver']
        i++
      false

    if MutationObserver
      observer = new MutationObserver (mutations) ->
        if currentView
          currentView.locale = defaultLocale = mutations[0].target.lang
          currentView.render()

      # listen for language attibute to change.
      observer.observe HTMLNode, {
        attributes: true
        attributeFilter: ['lang']
      }

    updateOnLanguageChange: (view) ->
      currentView = view
      # Set default language.
      currentView.locale = defaultLocale

    getLocale: () ->
      defaultLocale
