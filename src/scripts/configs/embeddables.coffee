define (require) ->

  _ = require('underscore')

  return {
    embeddableTypes : [{
      match : '#terp-'
      matchType : 'a'
      embeddableType : 'terp'
      apiUrl : () ->
        'https://openstaxtutor.org/terp/' + @.itemCode + '/quiz_start';
    },{
      match : '#ost\/api\/ex\/'
      matchType : 'a'
      embeddableType : 'exercise'
      apiUrl : () ->
        # # stub.  Comment out to use local exercises stub.
        # # Copied from https://exercises-dev1.openstax.org/api/exercises?q=tag:k12phys-ch04-s01-lo01
        # 'http://localhost:8000/data/exercises.json';

        'https://exercises-dev1.openstax.org/api/exercises?q=tag:' + @.itemCode;

      # # Adds flexibility for if data needs transformation post API call
      # # For now, not needed for when using actual API.  Comment in if using local stub.
      # filterDataCallback : (data) ->

      #   data.items = _.filter(data.items, (item) ->
      #     _.indexOf(item.tags, @itemCode) > -1
      #   , @)

      async : true
    }]
  }