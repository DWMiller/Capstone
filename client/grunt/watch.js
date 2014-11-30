module.exports = {
	js: {
		files: ['js/**/*'],
		tasks: ['newer:jshint', 'newer:concat'] //'newer:uglify'
	},
	sass: {
		files: ['sass/**/*'],
		tasks: ['sass']		
	},
	copy: {
		files: ['assets/**/*,js/localization/**/*'],
		tasks: ['newer:copy']				
	},
	// autoprefixer: {
	// 	files: ['dist/css/production.css'],
	// 	tasks: ['autoprefixer']		
	// },	
	html: {
		files: ['index.html'],
		tasks: ['newer:htmlmin']				
	},
	assets: {
		files: ['assets/**/*'],
		tasks: ['newer:copy']				
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