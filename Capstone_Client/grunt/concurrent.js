module.exports = {
  first: ['newer:jshint'],
  second:['newer:concat','newer:copy','newer:htmlmin','newer:sass'],
  third: ['newer:uglify','newer:autoprefixer'],
  fourth: ['clean'],
};