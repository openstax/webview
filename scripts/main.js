(function () {
  "use strict";

  require({
    paths: {
      cs: 'libs/require/plugins/require-cs/cs',
      'coffee-script': 'libs/require/plugins/require-cs/coffee-script'
    }
  }, ['cs!config']);

  /* If an error occurs in requirejs then change the loading HTML. */
  require.onError = function (err) {
    throw err;
  };

})();
