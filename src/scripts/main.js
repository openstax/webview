(function () {
  'use strict';

  console.info((process && process.env), 'HALLO?');

  // Load the config
  require(['config', 'compile-config'], function () {
    // Load the application after the config
    require(['cs!loader'], function (loader) {
      loader.init();
    });
  });

})();
