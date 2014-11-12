module.exports = {
  dist: {
    files: [
      // includes files within path and its sub-directories
      {expand: true, src: ['assets/**'], dest: 'dist/'},
      {expand: true, src: ['js/localization/**'], dest: 'dist/'},
    ]
  }
};