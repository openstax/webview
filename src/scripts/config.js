(function () {
  'use strict';

  require.config({
    // # Paths
    paths: {
      // ## Requirejs plugins
      text: '../../bower_components/requirejs-text/text',
      hbs: '../../bower_components/require-handlebars-plugin/hbs',

      // ## Google Analytics
      analytics: '//www.google-analytics.com/analytics',

      // ## Core Libraries
      jquery: '../../bower_components/jquery/dist/jquery',
      underscore: '../../bower_components/underscore/underscore',
      underscoreDeepExtend: '../../bower_components/underscore-deep-extend/index',
      backbone: '../../bower_components/backbone/backbone',
      'hbs/handlebars': '../../bower_components/require-handlebars-plugin/hbs/handlebars',

      // ## Backbone plugins
      'backbone-associations': '../../bower_components/backbone-associations/backbone-associations',

      // ## MathJax
      mathjax: '//cdn.mathjax.org/mathjax/2.6-latest/MathJax.js?config=MML_HTMLorMML',

      // Use Minified Aloha because loading files in a different requirejs context is a royal pain
      aloha: '../../bower_components/aloha-editor/target/build-profile-with-oer/rjs-output/lib/aloha',

      // ## UI Libraries and Helpers
      tooltip: 'helpers/backbone/views/attached/tooltip/tooltip',
      popover: 'helpers/backbone/views/attached/popover/popover',
      // Boostrap Plugins
      bootstrapAffix: '../../bower_components/bootstrap/js/affix',
      bootstrapAlert: '../../bower_components/bootstrap/js/alert',
      bootstrapButton: '../../bower_components/bootstrap/js/button',
      bootstrapCarousel: '../../bower_components/bootstrap/js/carousel',
      bootstrapCollapse: '../../bower_components/bootstrap/js/collapse',
      bootstrapDropdown: '../../bower_components/bootstrap/js/dropdown',
      bootstrapModal: '../../bower_components/bootstrap/js/modal',
      bootstrapPopover: '../../bower_components/bootstrap/js/popover',
      bootstrapScrollspy: '../../bower_components/bootstrap/js/scrollspy',
      bootstrapTab: '../../bower_components/bootstrap/js/tab',
      bootstrapTooltip: '../../bower_components/bootstrap/js/tooltip',
      bootstrapTransition: '../../bower_components/bootstrap/js/transition',

      // # Select2 multiselect widget
      select2: '../../bower_components/select2/select2',

      // # CoffeeScript
      cs: '../../bower_components/require-cs/cs',
      'coffee-script': '../../bower_components/coffeescript/docs/v1/browser-compiler/coffee-script',

      OpenStaxConceptCoach: '//localhost:3005/dist/full-build.min'
    },

    // # Packages
    packages: [{
      name: 'css',
      location: '../../bower_components/require-css',
      main: 'css'
    }, {
      name: 'less',
      location: '../../bower_components/require-less',
      main: 'less'
    }],

    // # Shims
    shim: {
      // ## Google Analytics
      'analytics': {
        exports: '__ga__'
      },

      // ## Aloha
      aloha: {
        // To disable MathJax comment out the `mathjax` entry in `deps` below.
        deps: ['jquery', 'mathjax', 'cs!configs/aloha', 'bootstrapModal', 'bootstrapPopover'],
        exports: 'Aloha',
        init: function () {
          return window.Aloha;
        }
      },

      // ## MathJax
      mathjax: {
        exports: 'MathJax',
        init: function () {
          // This config is copied from
          // `../../bower_components/aloha-editor/cnx/mathjax-config.coffee`
          //
          // It configures the TeX and AsciiMath inputs and the MML output
          // mostly for the Math editor.
          //
          // MathMenu and Zoom may not be needed but the `noErrors` is useful
          // for previewing as you type.
          window.MathJax.Hub.Config({
            jax: [
              'input/MathML',
              'input/TeX',
              'input/AsciiMath',
              'output/NativeMML',
              'output/HTML-CSS'
            ],
            extensions: [
              'asciimath2jax.js',
              'tex2jax.js',
              'mml2jax.js',
              'MathMenu.js',
              'MathZoom.js'
            ],
            tex2jax: {
              inlineMath: [
                ['[TEX_START]', '[TEX_END]'],
                ['\\(', '\\)'],
                ['\u200b\u200b\u200b', '\u200b\u200b\u200b']
              ]
            },
            TeX: {
              extensions: [
                'AMSmath.js',
                'AMSsymbols.js',
                'noErrors.js',
                'noUndefined.js'
              ],
              noErrors: {
                disabled: true
              }
            },
            AsciiMath: {
              noErrors: {
                disabled: true
              }
            }
          });

          return window.MathJax;
        }
      },

      // ## UI Libraries
      // # Bootstrap Plugins
      bootstrapAffix: ['jquery'],
      bootstrapAlert: ['jquery'],
      bootstrapButton: ['jquery'],
      bootstrapCarousel: ['jquery'],
      bootstrapCollapse: ['jquery', 'bootstrapTransition'],
      bootstrapDropdown: ['jquery'],
      bootstrapModal: ['jquery', 'bootstrapTransition'],
      bootstrapPopover: ['jquery', 'bootstrapTooltip'],
      bootstrapScrollspy: ['jquery'],
      bootstrapTab: ['jquery'],
      bootstrapTooltip: ['jquery'],
      bootstrapTransition: ['jquery'],

      // Select2
      select2: {
        deps: ['jquery', 'css!../../bower_components/select2/select2'],
        exports: 'Select2'
      }
    },

    less: {
      logLevel: 1,
      async: true,

      globalVars: {
        dependencyDir: '"/bower_components"'
      }
    },

    // Handlebars Requirejs Plugin Configuration
    // Used when loading templates `'hbs!...'`.
    hbs: {
      templateExtension: 'html',
      helperPathCallback: function (name) {
        return 'cs!helpers/handlebars/' + name;
      }
    }
  });

})();
