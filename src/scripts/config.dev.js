(function () {
  'use strict';

  define(function () {
    return function(settings){
      console.info(settings.environment, settings.conceptCoach.base);
      require.config({
        paths: {
          OpenStaxConceptCoach: settings.conceptCoach.base + 'full-build.min'
        },
        shim: {
          OpenStaxConceptCoach: {
            deps: ['css!' + settings.conceptCoach.base + 'main.min'],
            exports: 'OpenStaxConceptCoach'
          }
        }
      });
    }
  });

})();