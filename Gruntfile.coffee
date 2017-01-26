module.exports = (grunt) ->

  fs = require('fs')
  pkg = require('./package.json')

  alohaBuildConfig = grunt.file.read('bower_components/aloha-editor/build/aloha/build-profile-with-oer.js')
  alohaBuildConfig = eval(alohaBuildConfig)
  alohaBuildConfig.appDir = 'bower_components/aloha-editor/src/'
  alohaBuildConfig.baseUrl = 'lib/'
  alohaBuildConfig.dir = 'bower_components/aloha-editor/target/build-profile-with-oer/rjs-output'
  alohaBuildConfig.mainConfigFile = 'bower_components/aloha-editor/build/aloha/build-profile-with-oer.js'
  alohaBuildConfig.wrap =
    startFile: 'bower_components/aloha-editor/build/aloha/closure-start.frag'
    endFile: 'bower_components/aloha-editor/build/aloha/closure-end.frag'
  alohaBuildConfig.skipDirOptimize = true
  alohaBuildConfig.optimize = "uglify2"
  alohaBuildConfig.optimizeCss = "standard"
  alohaBuildConfig.separateCSS = false
  alohaBuildConfig.preserveLicenseComments = false

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

          # test globals
          beforeEach: true
          describe: true
          it: true
          chai: true
          sinon: true

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
              'settings/base'
              'settings/config'
              'cs!pages/error/error'
              'cs!pages/home/home'
              'cs!pages/contents/contents'
              'cs!pages/search/search'
              'cs!pages/browse-content/browse-content'
              'cs!pages/about/about'
              'cs!pages/tos/tos'
              'cs!pages/license/license'
              'cs!pages/donate/donate'
              'cs!helpers/backbone/views/editable'

              'select2'
              'bootstrapPopover'
              'cs!pages/workspace/workspace'
              'cs!pages/role-acceptance/role-acceptance'
              'cs!modules/media/editbar/editbar'
              'cs!configs/aloha'
            ]
            exclude: ['coffee-script', 'less/normalize']
            excludeShallow: ['settings', 'OpenStaxConceptCoach']
          }]

          done: (done, output) ->
            duplicates = require('rjs-build-analysis').duplicates(output)

            if duplicates.length > 0
              grunt.log.subhead('Duplicates found in requirejs build:')
              grunt.log.warn(duplicates)
              done(new Error('r.js built duplicate modules, please check the excludes option.'))

            done()

      aloha:
        options: alohaBuildConfig

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
      aloha:
        src: 'bower_components/aloha-editor/target/build-profile-with-oer/rjs-output/lib/aloha.js'
        dest: 'dist/scripts/aloha.js'
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

    # String Replace (HACK to update aloha path)
    'string-replace':
      dist:
        options:
          replacements: [{
            pattern: '../../bower_components/aloha-editor/target/build-profile-with-oer/rjs-output/lib/aloha'
            replacement: 'aloha'
          }]
        files:
          'dist/scripts/main.js': ['dist/scripts/main.js']

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
        log: false
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

    tests = grunt.file.expand(options.files).map((file) -> "../#{file}")

    # build the template
    template = grunt.file.read(options.template).replace('{{ tests }}', JSON.stringify(tests))

    # write template to tests directory and run tests
    grunt.file.write(options.runner, template)
    grunt.task.run('jshint', 'jsbeautifier', 'coffeelint', 'mocha')

  # Aloha
  # -----
  grunt.registerTask 'aloha', [
    'requirejs:aloha'
  ]

  # Dist
  # -----
  grunt.registerTask 'dist', [
    'aloha'
    'requirejs:compile'
    'copy'
    'string-replace'
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
