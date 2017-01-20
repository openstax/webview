(function () {
  'use strict';

  define(function () {
    return function(settings){
      console.info(settings.environment, settings.coach.base);
      require.config({
        paths: {
          aloha: 'aloha',
          OpenStaxConceptCoach: settings.coach.base + 'full-build.min'
        },
        shim: {
          OpenStaxConceptCoach: {
            deps: ['css!' + settings.coach.base + 'main.min'],
            exports: 'OpenStaxConceptCoach'
          }
        }
      });
    }
  });

})();