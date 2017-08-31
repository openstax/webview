define (require) ->

  devModeFlag = window.localStorage?.getItem('dev-mode')

  isEnabled = -> devModeFlag
  setEnabled = (theFlag) ->
    if theFlag
      window.localStorage.setItem('dev-mode', true)
    else
      window.localStorage.removeItem('dev-mode')
    devModeFlag = theFlag

  if /dev-mode=true/.test(window.location.search)
    setEnabled(true)
    # Clear it from the URL
    if window.location.search is '?dev-mode=true'
      window.location.search = ''
    else
      window.location.search = window.location.search.replace('dev-mode=true', '')
  else if /dev-mode=false/.test(window.location.search)
    setEnabled(false)
    # Clear it from the URL
    if window.location.search is '?dev-mode=false'
      window.location.search = ''
    else
      window.location.search = window.location.search.replace('dev-mode=false', '')

  return {
    isEnabled
    setEnabled
  }
