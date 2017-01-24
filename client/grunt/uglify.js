module.exports = {
  options: {
    compress: {
      //true
      drop_console: false,
    },
  },
  dist: { files: { 'dist/js/production.min.js': [ 'dist/js/production.js' ] } },
};
