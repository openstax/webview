define (require) ->
  return new class Localizer
    currentView = null
    HTMLNode = document.querySelector('html');
    observer = new MutationObserver (mutations) =>
      currentView.locale = mutations[0].target.lang
      currentView.render()

    # listen for language attibute to change.
    observer.observe HTMLNode, { attributeFilter: ['lang'] };

    updateOnLanguageChange: (view) ->
      currentView = view
      # Set default language.
      currentView.locale = HTMLNode.getAttribute('lang') || 'en-US'
