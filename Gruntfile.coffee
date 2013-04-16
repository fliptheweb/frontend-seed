module.exports = (grunt) ->
  grunt.initConfig
    # Concatinate js
    concat:
      main:
        src: [
          'js/libs/jquery.js'
          'js/mylibs/**/*.js'
        ]
        dest: 'build/scripts.js'

    # Minimalize js
    uglify:
      main:
        files:
          'build/scripts.min.js': '<%= concat.main.dest %>'

    # Run simple server for static
    connect:
      test:
        options:
          port: 8011
          base: '.'
          keepalive: true

    # Compile compass
    compass:
      prod:
        options:
          environment: 'production'
          outputStyle: 'compressed'
      dev:
        options:
          environment: 'development'
          outputStyle: 'expanded'

    # Sass instead of compass, cuz its support sourceMap
    sass:
      prod:
        options:
          compass: true
          style: 'compressed'
        files:
          'css/main.css': 'css/sass/main.scss'
      dev:
        options:
          compass: true
          sourcemap: true
          debugInfo: true
        files:
          'css/main.css': 'css/sass/main.scss'

    # Compile coffeeScript
    coffee:
      prod:
        options:
          join: true
        files:
          'js/main.js': 'js/*.coffee'
      dev:
        options:
          sourceMap: true
          join: true
        files:
          'js/main.js': 'js/*.coffee'
      test:
        files:
          'test/test.*.js':'test/test.*.coffee'

    # Watch for coffee, sass
    watch:
      dev:
        files: ['<%= coffee.dev.files %>', 'src/sass/*.scss']
        tasks: 'buildDev'
      test:
        files: ['<%= coffee.test.files %>']
        task: 'runTest'

    # Mocha client-side tests
    mocha:
      all: 'test/*.html'

    # Simple mocha
    simplemocha:
      test:
        src: 'test/test.*.js'
        options:
          reporter: 'spec'
          slow: 200
          timeout: 1000


  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.registerTask 'default',   ['concat', 'uglify']
  grunt.registerTask 'buildDev',  ['compass:dev', 'coffee:dev']

  grunt.registerTask 'buildTest', ['coffee:test']
  grunt.registerTask 'runTest',   ['buildTest', 'simplemocha:test']
