module.exports = {
    js: {
        src: [
            'js/libs/dependencies/*.js',
            'js/libs/*.js',
            'js/dmf.js',
            'js/config/**/*.js',
            'js/templates/**/*.js',
            'js/modules/**/*.js',
        ],
        dest: 'dist/js/production.js',
    },
    ie: {
        src:['js/ie/**/*.js'],
        dest: 'dist/js/shiv.js'
    }
}
