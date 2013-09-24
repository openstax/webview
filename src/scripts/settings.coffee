define (require) ->
  return {
    # Hostname and port for the cnxarchive server
    cnxarchive:
      host: location.hostname
      port: 6543
    
    # Google Analytics tracking ID
    analyticsID: 'UA-7903479-1'
  }
