(function () {
  'use strict';

  var coachBase = '//localhost:3005/dist/';
  require.config({
    paths: {
      OpenStaxConceptCoach: coachBase + 'full-build.min'
    },
    shim: {
      OpenStaxConceptCoach: {
        deps: ['css!' + coachBase + 'main.min'],
        exports: 'OpenStaxConceptCoach'
      }
    }
  });

})();