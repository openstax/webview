define (require) ->
  languages = require('cs!configs/languages')

  return {
    # Directory from which webview is served
    root: '/'

    # Hostname and port for the cnxarchive server
    cnxarchive:
      host: location.hostname
      port: 6543

    # Prefix to prepend to page titles
    titlePrefix: 'Connexions - '

    # Google Analytics tracking ID
    analyticsID: 'UA-7903479-1'

    # Supported languages
    languages: languages

    # Legacy URL
    legacy: 'http://cnx.org/'
  }
