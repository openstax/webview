(function () {
  'use strict';

  // Load the config
  require(['config', 'settings'], function (config, settings) {
    var dependencies = ['settings/feature-config', 'cs!loader', 'cs!helpers/underscore.deepExtend', 'jquery'];

    // jshint maxparams: 4
    require(dependencies, function (configureFor, loader, _, $) {
      // some paths and shims need to be configured based on settings.
      configureFor(settings, _, $);
      // Load the application after the config
      loader.init();
    });
  });

})();
