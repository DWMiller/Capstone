module.exports = {
	js: {
		files: ['js/**/*'],
		tasks: ['newer:jshint', 'newer:concat']
	},
	sass: {
		files: ['sass/**/*'],
		tasks: ['sass']		
	},
	copy: {
		files: ['assets/**/*'],
		tasks: ['newer:copy']				
	},
	html: {
		files: ['index.html'],
		tasks: ['newer:htmlmin']				
	},

	grunt: {
		files: ['grunt/**/*'],
		tasks: [],
		options: {
			spawn: false,
			reload: true
		}
	}
}