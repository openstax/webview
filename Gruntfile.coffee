module.exports = (grunt) ->

  fs = require('fs')
  pkg = require('./package.json')

  # Project configuration.
  grunt.initConfig
    pkg: pkg

    # Development nginx server
    # ----
    # Start with `grunt nginx:start`
    nginx:
      tasks: ['nginx']
      options:
        config: 'nginx.development.conf'
        prefix: './'

    # Lint
    # ----

    # JSHint
    jshint:
      options:
        globals:
          require: true
          define: true
          # NOTE: Use console.debug() to get output from tests
          console: true

          # test globals
          beforeEach: true
          describe: true
          it: true
          chai: true
          sinon: true
          extras: true
          cmsBooks: true
          exercises: true

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
        expr: true
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

      source: ['src/**/*.js', 'test/**/*.js']

    # JS Beautifier
    jsbeautifier:
      files: ['src/**/*.js', 'test/**/*.js']
      options:
        mode: "VERIFY_ONLY"
        js:
          spaceAfterAnonFunction: true
          wrapLineLength: 130
          indentSize: 2

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

      source: ['src/**/*.coffee', 'test/**/*.coffee']
      grunt: 'Gruntfile.coffee'

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
          waitSeconds: 360 # Jenkins takes a while to build (when running multiple jobs)
          findNestedDependencies: true
          removeCombined: false
          keepBuildDir: false
          preserveLicenseComments: false
          skipDirOptimize: true
          generateSourceMaps: true
          optimize: 'none'
          stubModules: ['cs']
          modules: [{
            name: 'main'
            include: [
              'cs!pages/error/error'
              'cs!pages/home/home'
              'cs!pages/contents/contents'
              'cs!pages/search/search'
              'cs!pages/browse-content/browse-content'
              'cs!pages/about/about'
              'cs!pages/tos/tos'
              'cs!pages/license/license'
              'cs!pages/donate/donate'

              # FIX: edit modules should be loaded in separate modules
              'cs!helpers/backbone/views/editable'
            ]
            exclude: ['coffee-script', 'less/normalize']
            excludeShallow: ['settings']
          }]

          done: (done, output) ->
            duplicates = require('rjs-build-analysis').duplicates(output)

            if duplicates.length > 0
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
      require:
        src: 'bower_components/requirejs/require.js'
        dest: 'dist/scripts/require.js'
      fonts:
        expand: true
        filter: 'isFile'
        flatten: true
        src: ['bower_components/font-awesome/fonts/**']
        dest: 'dist/fonts/'

    # Clean
    clean:
      files:
        src: [
          'dist/**/.*'
          'dist/build.txt'
          'dist/scripts/**/*'
          'dist/styles/**/*.less'
          '!dist/scripts/l20n.js'
          '!dist/scripts/Template.js'
          '!dist/scripts/browser.js'
          '!dist/scripts/main.js'
          '!dist/scripts/main.js.map'
          '!dist/scripts/require.js'
          '!dist/scripts/settings.js'
          '!dist/scripts/aloha.js'
        ]
        filter: 'isFile'
      directories:
        src: [
          'dist/styles'
          'dist/**/*'
        ]
        filter: (filepath) ->
          # Ignore files
          if not grunt.file.isDir(filepath) then return false

          # Remove /dist/test, and all directories inside /dist/scripts
          if filepath.match(/^dist\/(scripts\/|test)/) then return true

          # Remove empty directories
          return fs.readdirSync(filepath).length is 0

    # Uglify
    uglify:
      dist:
        options:
          sourceMap: true
          sourceMapIncludeSources: true
          sourceMapIn: 'dist/scripts/main.js.map'
        files:
          'dist/scripts/main.js': ['dist/scripts/main.js']
          'dist/scripts/require.js': ['dist/scripts/require.js']

    # HTML min
    htmlmin:
      dist:
        options:
          removeComments: true
          collapseWhitespace: true
        files:
          'dist/index.html': 'dist/index.html'
          'dist/maintenance.html': 'dist/maintenance.html'

    # Imagemin
    imagemin:
      images:
        options:
          cache: false
          optimizationLevel: 7
        files: [{
          expand: true
          cwd: 'dist/images/'
          src: ['**/*.{png,jpg,gif}']
          dest: 'dist/images/'
        }]

    test:
      options:
        template: 'test/index.template.html'
        runner: 'test/index.html'
        files: 'test/**/*.js'

    # Mocha for testing
    mocha:
      browser: ['test/index.html']
      options:
        reporter: 'Spec'
        run: false
        log: true
        logErrors: true
        timeout: 15000

  # Dependencies
  # ============
  for name of pkg.dependencies when name.substring(0, 6) is 'grunt-'
    grunt.loadNpmTasks(name)
  for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
    if grunt.file.exists("./node_modules/#{name}")
      grunt.loadNpmTasks(name)

  # Tasks
  # =====

  # Test
  # -----
  grunt.registerTask 'test', 'Run JS Unit tests', () ->
    options = @options()

    templateVars = {
      tests: JSON.stringify(grunt.file.expand(options.files).map((file) -> "../#{file}"))
      extras: grunt.file.read('src/data/extras.json')
      cmsBooks: grunt.file.read('src/data/cms-books.json')
      exercises: JSON.stringify([
        grunt.file.read('src/data/exercises/ex001.html'),
        grunt.file.read('src/data/exercises/ex002.html'),
        grunt.file.read('src/data/exercises/ex003.html'),
        grunt.file.read('src/data/exercises/ex004.html')
      ])
    }

    # build the template
    template = grunt.file.read(options.template)
    for key, value of templateVars
      template = template.replace("{{ #{key} }}", value)

    # write template to tests directory and run tests
    grunt.file.write(options.runner, template)
    grunt.task.run('jshint', 'jsbeautifier', 'coffeelint', 'mocha')
  # Aloha
  # -----

  # Dist
  # -----
  grunt.registerTask 'dist', [
    'requirejs:compile'
    'copy'
    'targethtml:dist'
    'clean'
    'uglify:dist'
    'htmlmin:dist'
    'imagemin'
  ]

  # Default
  # -----
  grunt.registerTask 'default', [
    'requirejs:compile'
    'copy'
    'targethtml:dist'
    'clean'
    'uglify:dist'
    'htmlmin:dist'
    'imagemin'
  ]
