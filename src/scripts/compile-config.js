(function () {
  'use strict';

  var coachBase = '//raw.githubusercontent.com/openstax/tutor-js/release/coach/';
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