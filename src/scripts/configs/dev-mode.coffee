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
  else if /dev-mode=false/.test(window.location.search)
    setEnabled(false)

  return {
    isEnabled
    setEnabled
  }
