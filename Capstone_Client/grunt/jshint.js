module.exports = {
    options: {
        reporter: require('jshint-stylish'),
        browser: true,
        devel:true,
        strict: true,
        globals: {
            $: true,
            app: true,
        },
    },
    files: ['js/config/**/*.js', 'js/modules/**/*.js']
}
