(function () {
  'use strict';

  // Load the config
  require(['config', 'settings'], function (config, settings) {
    // jshint maxparams: 4
    require(['settings/feature-config', 'cs!loader', 'cs!helpers/underscore.deepExtend', 'jquery'],
      function (configureFor, loader, _, $) {
        // some paths and shims need to be configured based on settings.
        configureFor(settings, _, $, function () {        
          // Load the application after the config
          loader.init();
        });
      }
    );
  });

})();
