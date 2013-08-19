(function () {
  'use strict';

  // Load the config
  require({
    baseUrl: '../../src/scripts/',

    paths: {
      tests: '../../tests',
      mock: '../../tests/data',
      jquery: 'libs/jquery/jquery',
      mockjax: 'libs/jquery-mockjax/jquery.mockjax'
    },

    shim: {
      mockjax: ['jquery']
    }
  }, ['config'], function () {
    // Load the mock data
    require(['cs!tests/mock'], function () {
      // Load the application after the config
      require(['cs!loader'], function (loader) {
        loader.init({test: true});
      });
    });
  });

  /* If an error occurs in requirejs then change the loading HTML. */
  require.onError = function (err) {
    throw err;
  };

})();
