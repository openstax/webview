require.config
  # # Configure Library Locations
  paths:
    # ## Requirejs plugins
    text: 'libs/require/plugins/text'
    hbs: 'libs/require/plugins/require-handlebars/hbs'

    # ## Core Libraries
    jquery: 'libs/jquery'
    underscore: 'libs/lodash'
    backbone: 'libs/backbone/backbone'

    # ## UI Libraries
    # Bootstrap Plugins
    bootstrapAffix: 'libs/bootstrap/js/affix'
    bootstrapAlert: 'libs/bootstrap/js/alert'
    bootstrapButton: 'libs/bootstrap/js/button'
    bootstrapCarousel: 'libs/bootstrap/js/carousel'
    bootstrapCollapse: 'libs/bootstrap/js/collapse'
    bootstrapDropdown: 'libs/bootstrap/js/dropdown'
    bootstrapModal: 'libs/bootstrap/js/modal'
    bootstrapPopover: 'libs/bootstrap/js/popover'
    bootstrapScrollspy: 'libs/bootstrap/js/scrollspy'
    bootstrapTab: 'libs/bootstrap/js/tab'
    bootstrapTooltip: 'libs/bootstrap/js/tooltip'
    bootstrapTransition: 'libs/bootstrap/js/transition'

    # ## Handlebars Dependencies
    Handlebars: 'libs/require/plugins/require-handlebars/Handlebars'
    i18nprecompile: 'libs/require/plugins/require-handlebars/hbs/i18nprecompile'
    json2: 'libs/require/plugins/require-handlebars/hbs/json2'

  # # Map prefixes
  map:
    '*':
      css: 'libs/require/plugins/require-css/css'
      less: 'libs/require/plugins/require-less/less'

  # # Shims
  # Used to support libraries that were not written for AMD
  #
  # List the dependencies and what global object is available
  # when the library is done loading (for jQuery plugins this can be `jQuery`)
  shim:
    # ## Core Libraries
    underscore:
      exports: '_'

    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'

    # ## UI Libraries
    # Bootstrap Plugins
    bootstrapAffix: ['jquery']
    bootstrapAlert: ['jquery']
    bootstrapButton: ['jquery']
    bootstrapCarousel: ['jquery']
    bootstrapCollapse: ['jquery', 'bootstrapTransition']
    bootstrapDropdown: ['jquery']
    bootstrapModal: ['jquery']
    bootstrapPopover: ['jquery', 'bootstrapTooltip']
    bootstrapScrollspy: ['jquery']
    bootstrapTab: ['jquery']
    bootstrapTooltip: ['jquery']
    bootstrapTransition: ['jquery']

  # Handlebars Requirejs Plugin Configuration
  # This configures `requirejs` plugins (used when loading templates `'hbs!...'`).
  hbs:
    disableI18n: true
    helperPathCallback: (name) ->
      return "cs!helpers/handlebars/#{name}"
    templateExtension: 'html'
