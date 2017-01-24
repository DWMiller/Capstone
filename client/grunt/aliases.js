module.exports = {
  build: [
    'concat',
    'copy',
    'htmlmin',
    'sass',
    'uglify',
    'version',
    'clean',
  ],
  default: [ 'build' ],
};
