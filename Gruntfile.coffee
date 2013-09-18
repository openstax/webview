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
        globals:
          require: true

        # Enforcing options
        camelcase: true
        curly: true
        eqeqeq: true
        forin: true
        immed: true
        indent: 2
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

      source: ['src/**/*.js']

    # JS Beautifier
    jsbeautifier:
      files: ['src/**/*.js']
      options:
        js:
          mode: "VERIFY_ONLY"
          space_after_anon_function: true
          wrap_line_length: 120
          indent_size: 2

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
          value: 13

      source: ['src/**/*.coffee']
      grunt: 'Gruntfile.coffee'

    # Recess
    recess:
      dist:
        options:
          strictPropertyOrder: false
        src: ['src/**/*.less', '!src/scripts/pages/app/app.less'] # Don't lint bootstrap

    # Dist
    # ----

    # Requirejs Optimizer
    requirejs:
      compile:
        options:
          appDir: 'src'
          baseUrl: 'scripts'
          dir: 'dist'
          mainConfigFile: 'src/scripts/config.js'
          findNestedDependencies: true
          removeCombined: false
          keepBuildDir: false
          preserveLicenseComments: false
          skipDirOptimize: true
          optimize: 'uglify2'
          # CSS Base points to project root for bower_components (https://github.com/jrburke/r.js/issues/412)
          cssBase: '../../'

          stubModules: ['cs']
          modules: [{
            name: 'main'
            create: true
            include: [
              'css'
              'main'
              'cs!pages/home/home'
              'cs!pages/content/content'
              'cs!pages/search/search'
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

    # Target HTML
    targethtml:
      dist:
        files:
          'dist/index.html': 'dist/index.html'

    # Copy
    copy:
      dist:
        src: 'bower_components/requirejs/require.js'
        dest: 'dist/scripts/require.js'

    # Clean
    clean:
      files:
        src: [
          'dist/**/.*'
          'dist/build.txt'
          'dist/scripts/**/*'
          '!dist/scripts/main.js'
          '!dist/scripts/require.js'
        ]
        filter: 'isFile'
      directories:
        src: [
          'dist/styles'
          'dist/test'
          'dist/**/*'
        ]
        filter: (filepath) ->
          # Ignore files
          if not grunt.file.isDir(filepath) then return false

          # Remove /dist/styles, /dist/test, and all directories inside /dist/scripts
          if filepath.match(/^dist\/(scripts\/|styles|test)/) then return true

          # Remove empty directories
          return fs.readdirSync(filepath).length is 0

    # Uglify
    uglify:
      dist:
        files:
          'dist/scripts/require.js': ['dist/scripts/require.js']

    # HTML min
    htmlmin:
      dist:
        options:
          removeComments: true
          collapseWhitespace: true
        files:
          'dist/index.html': 'dist/index.html'

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
    'copy:dist'
    'targethtml:dist'
    'clean'
    'uglify:dist'
    'htmlmin:dist'
    'imagemin'
  ]

  # Default
  # -----
  grunt.registerTask 'default', [
    'requirejs'
    'copy:dist'
    'targethtml:dist'
    'clean'
    'uglify:dist'
    'htmlmin:dist'
    'imagemin'
  ]
