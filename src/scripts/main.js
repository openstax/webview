(function () {
  'use strict';

  // Load the config
  require(['config', 'settings'], function (config, settings) {
    require(['settings/config', 'cs!loader', 'cs!helpers/underscore.deepExtend'], function (configureFor, loader, _) {
      // some paths and shims need to be configured based on settings.
      configureFor(settings, _);

      // Load the application after the config
      if (settings.hasFeature('authoring')){
        require(['authoring'], function () {
          loader.init();
        });
      } else {
        loader.init();
      }
    });
  });

})();
