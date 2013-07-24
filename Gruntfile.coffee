module.exports = (grunt) ->

  pkg = require('./package.json')

  # Project configuration.
  grunt.initConfig
    pkg: pkg

    # Lint
    # ----
    coffeelint:
      # global options
      options:
        arrow_spacing:
          level: 'error'
        line_endings:
          level: 'error'
          value: 'unix'
        max_line_length:
          value: 'ignore'

      source: 'site/scripts/**/*.coffee'
      grunt: 'Gruntfile.coffee'

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
    'recess'
    'coffeelint'
  ]
