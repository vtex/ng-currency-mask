module.exports = (grunt) ->
  pkg = grunt.file.readJSON 'package.json'

  config =
    clean: ['dist']

    coffee:
      main:
        expand: true
        cwd: 'src/'
        src: ['**/**.coffee']
        dest: 'dist/'
        ext: '.js'

    uglify:
      options:
        sourceMap: true
        banner: "/*! #{ pkg.name } - v#{ pkg.version } */"
      main:
        expand: true
        cwd: 'dist/'
        src: '**/**.js'
        dest: 'dist/'
        ext: '.min.js'

    karma:
      unit:
        options:
          frameworks: ['jasmine']
          singleRun: true,
          browsers: ['PhantomJS']
          preprocessors: '**/*.coffee': ['coffee']
          files: [
            'spec/lib/angular.js'
            'spec/lib/angular-mocks.js'
            'dist/ng-currency-mask.js'
            'spec/tests.coffee'
          ]

  tasks =
    build: ['clean', 'coffee', 'uglify']
    test: ['karma']
    default: ['build', 'test']

  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..4] is 'grunt'
  grunt.config.init config
  grunt.registerTask name, array for name, array of tasks
