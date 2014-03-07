(function () {
  'use strict';

  require.config({
    // # Paths
    paths: {
      // ## Requirejs plugins
      text: '../../bower_components/requirejs-text/text',
      hbs: '../../bower_components/require-handlebars-plugin/hbs',
      cs: '../../bower_components/require-cs/cs',

      // ## Core Libraries
      jquery: '../../bower_components/jquery/dist/jquery',
      underscore: '../../bower_components/lodash/dist/lodash',
      backbone: '../../bower_components/backbone/backbone',
      'hbs/handlebars': '../../bower_components/require-handlebars-plugin/hbs/handlebars',

      // ## Backbone plugins
      'backbone-associations': '../../bower_components/backbone-associations/backbone-associations',

      // ## MathJax
      mathjax: 'http://cdn.mathjax.org/mathjax/2.3-latest/MathJax.js?config=MML_HTMLorMML',

      // Use Minified Aloha ( `r.js -o build/aloha/build-profile-with-oer.js` )
      // because loading files in a different requirejs context is a royal pain
      aloha: '../../bower_components/aloha-editor/target/build-profile-with-oer/rjs-output/lib/aloha',
      // Override location of jquery-ui and use our own. Because
      // jquery-ui and bootstrap conflict in a few cases (buttons,
      // tooltip) our copy has those removed.
      jqueryui: '../../bower_components/aloha-editor/oerpub/js/jquery-ui-1.9.0.custom-aloha',

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

      // ## CoffeeScript Compiler
      'coffee-script': '../../bower_components/coffee-script/index'
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
      // ## Aloha
      aloha: {
        // To disable MathJax comment out the `mathjax` entry in `deps` below.
        deps: ['jquery', 'jqueryui', 'mathjax', 'cs!configs/aloha', 'bootstrapModal', 'bootstrapPopover',
          'css!../../bower_components/aloha-editor/target/build-profile-with-oer/rjs-output/lib/aloha'
        ],
        exports: 'Aloha',
        init: function () {
          return window.Aloha;
        }
      },

      // ## MathJax
      mathjax: {
        // deps: ['cs!../../bower_components/aloha-editor/cnx/mathjax-config'],
        exports: 'MathJax',
        init: function () {
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
                ['\\(', '\\)']
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
      bootstrapModal: ['jquery'],
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
