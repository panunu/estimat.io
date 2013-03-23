module.exports = function(grunt) {
    grunt.loadNpmTasks('grunt-contrib-imagemin');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-sed');

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

        copy: {
            main: {
                files: [
                    { expand: true, src: [ 'client/*.html' ], flatten: true, dest: 'web/' }
                ]
            }
        },

        concat: {
            options: {},
            main: {
                src: [ 'components/**/**.min.js' ],
                dest: 'web/assets/js/libraries.js'
            }
        },

        coffee: {
            compile: {
                files: {
                    'web/assets/js/client.js': 'client/client.coffee'
                }
            }
        }

    });

    grunt.registerTask('default', [ 'copy:main', 'concat:main', 'coffee:compile' ]);

};




