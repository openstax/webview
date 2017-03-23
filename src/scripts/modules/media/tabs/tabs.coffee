define (require) ->
  feature = require('cs!helpers/feature')
  tabsWithAuthoring = require('cs!./tabs-authoring')
  tabs = require('cs!./tabs-base')
  return feature(tabs, 'authoring': tabsWithAuthoring)
