module.exports = {
	js: {
		files: ['js/**/*'],
		tasks: ['newer:jshint', 'newer:concat','version']
	},
	sass: {
		files: ['sass/**/*'],
		tasks: ['sass','version']		
	},
	copy: {
		files: ['assets/**/*'],
		tasks: ['newer:copy']				
	},
	html: {
		files: ['index.html'],
		tasks: ['newer:htmlmin','version']				
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