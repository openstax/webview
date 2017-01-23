(function () {
  'use strict';

  // Load the config
  require(['config', 'settings'], function(config, settings){
    require(['config.' + settings.environment, 'cs!loader'], function(configureFor, loader){
      configureFor(settings);
      // Load the application after the config
      loader.init();
    });
  });

})();
