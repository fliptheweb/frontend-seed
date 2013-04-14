module.exports = (grunt) ->
  grunt.initConfig
    concat:
      main:
        src: [
          'js/libs/jquery.js'
          'js/mylibs/**/*.js'
        ]
        dest: 'build/scripts.js'

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
      main:
        options:
          environment: 'production'
          outputStyle: 'compressed'
      dev:
        options:
          environment: 'development'
          outputStyle: 'expanded'

    # Compile coffeeScript
    coffee:
      dev:
        options:
          sourceMap: true
        files:
          'js/main.js': 'js/*.coffee'

    # Watch for coffee, sass
    watch:
      scripts:
        files: 'js/*.coffee',
        tasks: 'coffee'
      styles:
        files: 'css/sass/*.scss'
        tasks: 'compass'

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.registerTask 'default', ['concat', 'uglify']