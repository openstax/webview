define (require) ->
  _ = require('underscore')
  Backbone = require('backbone')
  settings = require('settings')

  SERVER = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}"

  return new class Subjects extends Backbone.Collection
    url: () -> "#{SERVER}/extras"

    initialize: () ->
      @fetch({reset: true})

    parse: (response, options) ->
      subjects = response.subjects

      _.each subjects, (subject) ->
        switch subject.name
          when 'Arts' then subject.image = '/images/subjects/art.jpg'
          when 'Business' then subject.image = '/images/subjects/business.jpg'
          when 'Humanities' then subject.image = '/images/subjects/humanities.jpg'
          when 'Mathematics and Statistics' then subject.image = '/images/subjects/math.jpg'
          when 'Science and Technology' then subject.image = '/images/subjects/science.jpg'
          when 'Social Sciences' then subject.image = '/images/subjects/social_science.jpg'

      return subjects
