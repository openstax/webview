(function () {
    'use strict';

    require.config({
        // # Application Configs
        config: {
            loader: {
                root: '/' // The root URI prefixed on all non-external AJAX and Backbone URIs
            }
        },

        // # Paths
        paths: {
            // ## Requirejs plugins
            text: 'libs/requirejs-text/text',
            hbs: 'libs/require-handlebars-plugin/hbs',
            cs: 'libs/require-cs/cs',

            // ## Core Libraries
            jquery: 'libs/jquery/jquery',
            underscore: 'libs/lodash/lodash',
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
            Handlebars: 'libs/require-handlebars-plugin/Handlebars',
            i18nprecompile: 'libs/require-handlebars-plugin/hbs/i18nprecompile',
            json2: 'libs/require-handlebars-plugin/hbs/json2',

            // ## CoffeeScript Compiler
            'coffee-script': 'libs/coffee-script/index'
        },

        // # Packages
        packages: [{
            name: 'css',
            location: 'libs/require-css',
            main: 'css'
        }, {
            name: 'less',
            location: 'libs/require-less',
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
