module.exports = {
	dist: {                                      // Target
	  options: {                                 // Target options
	    removeComments: true,
	    collapseWhitespace: true,
	    collapseBooleanAttributes: true,
	    removeRedundantAttributes: false,
	    removeEmptyAttributes: true,
	    removeOptionalTags: true
	  },
	  files: {                                   // Dictionary of files
	    'dist/index.html': 'index.html',     // 'destination': 'source'
	  }
	}
}