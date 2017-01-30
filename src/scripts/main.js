(function () {
  'use strict';

  // Load the config
  require(['config', 'settings'], function (config, settings) {
    // jshint maxparams: 5
    require([
        'settings/feature-config', 'settings/concept-coach-enabled-config',
        'cs!loader', 'cs!helpers/underscore.deepExtend', 'jquery'
      ],
      function (configureFor, makeCoachEnabledConfig, loader, _, $) {
        // some paths and shims need to be configured based on settings.
        configureFor(settings, makeCoachEnabledConfig, _, $)
          .always(function () {
            // Load the application after the config
            loader.init();
          });
      }
    );
  });

})();
