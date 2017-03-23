define (require) ->
  feature = require('cs!helpers/feature')
  headerWithCoach = require('cs!./header-coach')
  header = require('cs!./header-base')
  return feature(header, conceptCoach: headerWithCoach)
