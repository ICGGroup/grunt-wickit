#
# * grunt-wickit
# * https://github.com/ICGGroup/grunt-wickit
# *
# * Copyright (c) 2013 Trimeego
# * Licensed under the MIT license.
# 
"use strict"
module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    jshint:
      all: ["Gruntfile.js", "tasks/*.js", "<%= nodeunit.tests %>"]
      options:
        jshintrc: ".jshintrc"

    
    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ["tmp", ".wikis"]

    
    # Configuration to be run (and then tested).
    wickit:
      default_options:
        options: 
          gitUrl: "git@github.com:ICGGroup/grunt-wickit.wiki.git"
          sitePath: "tmp/default"

      custom_options:
        options:
          gitUrl: "git@github.com:ICGGroup/grunt-wickit.wiki.git"
          sitePath: "tmp/custom"

    thumbify:
      simpletest:
        options:
          src: "tmp/**/*.html"
          dest: "thumbs"

    # Unit tests.
    nodeunit:
      tests: ["test/*_test.coffee"]

  
  # Actually load this plugin's task(s).
  grunt.loadTasks "tasks"
  
  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-nodeunit"
  
  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask "test", ["clean", "wickit", "thumbify", "nodeunit"]
  
  # By default, lint and run all tests.
  grunt.registerTask "default", ["jshint", "test"]