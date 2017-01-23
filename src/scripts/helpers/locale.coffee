define (require) ->
  return new class Localizer

    currentView = null
    fallbackLanguage = 'en-US'
    HTMLNode = document.querySelector('html')

    # Detect support for MutationObserver.
    MutationObserver = do ->
      prefixes = ['WebKit', 'Moz', 'O', 'Ms', '']
      i = 0
      while i < prefixes.length
        if prefixes[i] + 'MutationObserver' of window
          return window[prefixes[i] + 'MutationObserver']
        i++
      false

    if MutationObserver
      observer = new MutationObserver (mutations) ->
        if currentView
          currentView.locale = mutations[0].target.lang
          currentView.render()

      # listen for language attibute to change.
      observer.observe HTMLNode, {
        attributes: true
        attributeFilter: ['lang']
      }

    updateOnLanguageChange: (view) ->
      currentView = view
      # Set default language & Ensure proper language code
      # FIXFOR:
      # In FireFox onLoad default lang. code is set to what is in `lang` html's attibute,
      # this behaviours causes images to load in Eng. even if site is render in other language after all.
      currentView.locale = HTMLNode.getAttribute('lang') || fallbackLanguage

    getLocale: () ->

      HTMLNode.getAttribute('lang') || fallbackLanguage
