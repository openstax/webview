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
      jquery: '../../bower_components/jquery/jquery',
      underscore: '../../bower_components/lodash/dist/lodash.underscore',
      backbone: '../../bower_components/backbone/backbone',

      // ## Backbone plugins
      'backbone-relational': '../../bower_components/backbone-relational/backbone-relational',

      // ## UI Libraries
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

      // ## Handlebars Dependencies
      Handlebars: '../../bower_components/require-handlebars-plugin/Handlebars',
      i18nprecompile: '../../bower_components/require-handlebars-plugin/hbs/i18nprecompile',
      json2: '../../bower_components/require-handlebars-plugin/hbs/json2',

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
      // ## Core Libraries
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },

      // ## Backbone plugins
      'backbone-relational': {
        deps: ['backbone']
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
