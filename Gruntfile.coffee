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

    connect:
      test:
        options:
          port: 8000
          base: '.'

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.registerTask 'default', ['concat', 'uglify']