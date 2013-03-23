module.exports = function(grunt) {
    grunt.loadNpmTasks('grunt-contrib-imagemin');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-sed');
    grunt.loadNpmTasks('grunt-contrib-concat');

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        watch: {
            less: {
                files: 'app/**/*.less',
                tasks: ['less:dev', 'sed:version'],
                options: {
                    nocase: true
                }
            },

            html: {
                files: ['app/assets/**/*.html'],
                tasks: ['copy:dev', 'sed:version'],
                options: {
                    nocase: true
                }
            },

            js: {
                files: 'app/assets/**/*.js',
                tasks: ['uglify:dev', 'sed:version'],
                options: {
                    nocase: true
                }
            }
        },

        concat: {
            options: {},
            dev: {
                src: ['components/**.min.js' ],
                dest: 'web/assets/libraries.js'
            }
        }

    });

    grunt.registerTask('default', [ 'concat:dev' ]);

};




