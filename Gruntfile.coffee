module.exports = (grunt) ->

  pkg = require('./package.json')

  # Project configuration.
  grunt.initConfig
    pkg: pkg

    # Lint
    # ----

    # JSHint
    jshint:
      options:
        ignores: ['site/scripts/libs/**']
        globals:
          require: true

        # Enforcing options
        camelcase: true
        curly: true
        eqeqeq: true
        forin: true
        immed: true
        indent: 4
        latedef: true
        newcap: true
        noarg: true
        noempty: true
        nonew: true
        plusplus: false
        quotmark: 'single'
        undef: true
        unused: true
        strict: true
        trailing: true
        maxparams: 3
        maxlen: 120
        # Relaxing options
        asi: false
        boss: false
        debug: false
        eqnull: false
        evil: false
        expr: false
        funcscope: false
        globalstrict: false
        iterator: false
        lastsemic: false
        laxbreak: false
        laxcomma: false
        loopfunc: false
        multistr: false
        proto: false
        scripturl: false
        smarttabs: false
        shadow: false
        sub: false
        supernew: false
        validthis: false
        # Environments
        browser: true
        devel: false

      source: [
        'site/scripts/**/*.js'
      ]

    # JS Beautifier
    jsbeautifier:
      files: ['site/scripts/**/*.js', '!site/scripts/libs/**']
      options:
        mode: "VERIFY_ONLY"
        keep_array_indentation: true
        space_after_anon_function: true
        wrap_line_length: 120

    # CoffeeLint
    coffeelint:
      options:
        arrow_spacing:
          level: 'error'
        line_endings:
          level: 'error'
          value: 'unix'
        max_line_length:
          level: 'error'
          value: 120

      source: 'site/scripts/**/*.coffee'
      grunt: 'Gruntfile.coffee'

    # Recess
    recess:
      dist:
        options:
          strictPropertyOrder: false
        src: [
          'site/styles/**/*.less'
          'site/scripts/modules/**/*.less'
        ]

  # Dependencies
  # ============
  for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
    grunt.loadNpmTasks(name)

  # Tasks
  # =====

  # Travis CI
  # -----
  grunt.registerTask 'test', [
    'jshint'
    'jsbeautifier'
    'coffeelint'
    'recess'
  ]
