(function () {
    'use strict';

    require.config({
        // # Paths
        paths: {
            // ## Requirejs plugins
            text: 'libs/require/plugins/text',
            hbs: 'libs/require/plugins/require-handlebars/hbs',
            cs: 'libs/require/plugins/require-cs/cs',

            // ## Core Libraries
            jquery: 'libs/jquery',
            underscore: 'libs/lodash',
            backbone: 'libs/backbone/backbone',

            // ## UI Libraries
            // Boostrap Plugins
            bootstrapAffix: 'libs/bootstrap/js/affix',
            bootstrapAlert: 'libs/bootstrap/js/alert',
            bootstrapButton: 'libs/bootstrap/js/button',
            bootstrapCarousel: 'libs/bootstrap/js/carousel',
            bootstrapCollapse: 'libs/bootstrap/js/collapse',
            bootstrapDropdown: 'libs/bootstrap/js/dropdown',
            bootstrapModal: 'libs/bootstrap/js/modal',
            bootstrapPopover: 'libs/bootstrap/js/popover',
            bootstrapScrollspy: 'libs/bootstrap/js/scrollspy',
            bootstrapTab: 'libs/bootstrap/js/tab',
            bootstrapTooltip: 'libs/bootstrap/js/tooltip',
            bootstrapTransition: 'libs/bootstrap/js/transition',

            // ## Handlebars Dependencies
            Handlebars: 'libs/require/plugins/require-handlebars/Handlebars',
            i18nprecompile: 'libs/require/plugins/require-handlebars/hbs/i18nprecompile',
            json2: 'libs/require/plugins/require-handlebars/hbs/json2',

            // ## Coffeescript Compiler
            'coffee-script': 'libs/require/plugins/require-cs/coffee-script'
        },

        // # Packages
        packages: [{
            name: 'css',
            location: 'libs/require/plugins/require-css',
            main: 'css'
        }, {
            name: 'less',
            location: 'libs/require/plugins/require-less',
            main: 'less'
        }],

        // # Shims
        shim: {
            // ## Core Libraries
            underscore: {
                exports: '_'
            },
            backbone: {
                deps: ['underscore', 'jquery'],
                exports: 'Backbone'
            },

            // ## UI Libraries
            // # Bootstrap Plugins
            bootstrapAffix: ['jquery'],
            bootstrapAlert: ['jquery'],
            bootstrapButton: ['jquery'],
            bootstrapCarousel: ['jquery'],
            bootstrapCollapse: ['jquery', 'bootstrapTransition'],
            bootstrapDropdown: ['jquery'],
            bootstrapModal: ['jquery'],
            bootstrapPopover: ['jquery', 'bootstrapTooltip'],
            bootstrapScrollspy: ['jquery'],
            bootstrapTab: ['jquery'],
            bootstrapTooltip: ['jquery'],
            bootstrapTransition: ['jquery']
        },

        // Handlebars Requirejs Plugin Configuration
        // Used when loading templates `'hbs!...'`.
        hbs: {
            disableI18n: true,
            helperPathCallback: function (name) {
                return 'cs!helpers/handlebars/' + name;
            },
            templateExtension: 'html'
        }
    });

})();