define (require) ->
  return (router) ->
    router.route 'workspace', 'workspace', () ->
      router.appView.render('workspace')

    router.route /^users\/role-acceptance\/(.+)/, 'role-acceptance', () ->
      router.appView.render('role-acceptance')
