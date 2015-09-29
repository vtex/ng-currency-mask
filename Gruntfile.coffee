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

  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..4] is 'grunt'
  grunt.config.init config
  grunt.registerTask 'default', ['clean', 'coffee', 'uglify']
