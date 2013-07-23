(function () {
    "use strict";

    // Load the config
    require({
        paths: {
            cs: 'libs/require/plugins/require-cs/cs',
            'coffee-script': 'libs/require/plugins/require-cs/coffee-script'
        }
    }, ['cs!config'], function () {
        // Load the application after the config
        require(['cs!loader'], function(loader) {
            loader.init();
        });
    });

    /* If an error occurs in requirejs then change the loading HTML. */
    require.onError = function (err) {
        throw err;
    };

})();
