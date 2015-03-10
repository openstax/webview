define (require) ->

  return {
    embeddableAPIs : {
      exercise : (itemCode)->
        # stub.
        'http://localhost:8000/data/exercises.json';

        # actual API url. code works with this. server is down at the moment...
        # also i think CORS header isn't set yet. 
        # 'https://exercises-dev1.openstax.org/api/exercises?q=tag:' + itemCode;

      simulation : (itemCode)->
        'http://connexions.github.io/simulations/' + itemCode;

      terp : (itemCode)->
        'https://openstaxtutor.org/terp/' + itemCode + '/quiz_start';

    },

    embeddableTypes : [{
      match : '#terp-',
      matchType : 'a',
      embeddableType : 'terp',
    },{
      match : '#ost\/api\/ex\/',
      matchType : 'a',
      embeddableType : 'exercise',
      async : true,
    },{
      match : '#sims-',
      matchType : 'iframe',
      embeddableType : 'simulation'
    }]
  }