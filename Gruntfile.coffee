module.exports = (grunt) ->

  fs = require('fs')
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
        maxcomplexity: 10
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
        cyclomatic_complexity:
          level: 'error'
          value: 10

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

    # Dist
    # ----

    # Requirejs Optimizer
    requirejs:
      compile:
        options:
          appDir: 'site'
          baseUrl: 'scripts'
          dir: 'dist'
          mainConfigFile: 'site/scripts/config.js'
          findNestedDependencies: true
          removeCombined: true
          keepBuildDir: false
          preserveLicenseComments: false
          skipDirOptimize: true
          optimize: 'uglify2'

          stubModules: ['cs']
          modules: [{
              name: 'main'
              create: true
              include: [
                  'css'
                  'main'
                  'cs!pages/home/home'
              ]
              excludeShallow: [
                  'css/css-builder'
                  'less/lessc-server'
                  'less/lessc'
              ]
              exclude: ['coffee-script']
          }]

          done: (done, output) ->
            duplicates = require('rjs-build-analysis').duplicates(output)

            if (duplicates.length > 0)
              grunt.log.subhead('Duplicates found in requirejs build:')
              grunt.log.warn(duplicates)
              done(new Error('r.js built duplicate modules, please check the excludes option.'))

            done()

    # Clean
    clean:
      files:
        src: [
          'dist/**/.*'
          'dist/build.txt'
          'dist/styles/**/*'
          'dist/scripts/**/*'
          '!dist/scripts/main.js'
          '!dist/scripts/libs/requirejs/require.js'
        ]
        filter: 'isFile'
      directories:
        src: [
          'dist/**/*'
        ]
        filter: (filepath) ->
          # Ignore files
          if not grunt.file.isDir(filepath) then return false

          # Remove all directories inside /dist/scripts
          if filepath.match(/^dist\/scripts\//)
            # Don't remove the matching directories
            if filepath is 'dist/scripts/libs' or
                filepath is 'dist/scripts/libs/requirejs'
              return false
            else
              return true

          # Remove empty directories
          return fs.readdirSync(filepath).length is 0

    # Uglify
    uglify:
      dist:
        files:
          'dist/scripts/libs/requirejs/require.js': ['dist/scripts/libs/requirejs/require.js']

    # Imagemin
    imagemin:
      png:
        options:
          optimizationLevel: 7
        files: [{
          expand: true
          cwd: 'dist/images/'
          src: ['**/*.png']
          dest: 'dist/images/'
          ext: '.png'
        }]

    # Install
    # ----

    # Shell
    shell:
      bower:
        command: 'bower install'

  # Dependencies
  # ============
  for name of pkg.dependencies when name.substring(0, 6) is 'grunt-'
    grunt.loadNpmTasks(name)
  for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
    if grunt.file.exists("./node_modules/#{name}")
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

  # Dist
  # -----
  grunt.registerTask 'dist', [
    'requirejs'
    'clean'
    'uglify:dist'
    'imagemin'
  ]

  # Install
  # -----
  grunt.registerTask 'install', [
    'shell:bower'
  ]
