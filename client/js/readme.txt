Capstone/client/js
=============================================================================== 
	This directory contains all JavaScript files utilized in this
application, and is thus where most functionality may be found.

    Subdirectories
    ===========================================================================   

        config
    	=======================================================================
            Contains config files for the application. Generally, these are 
        paired with modules but that is not a requirement. One config file may 
        may also constain settings for more than one module, as demonstrated in
        config/base.config.js.

        ie
    	=======================================================================
            A handful of scripts to be inserted when running on older browsers.
        Specifically, this will allow versions of IE less than 8 to emulate 
        more advanced browser functionality.
       
        libs
    	=======================================================================
            Contains all 3rd party libraries utilized by the application.
    		
        localization
    	=======================================================================    	
            Contains a series of JSON files, each representing key:value 
        bindings of strings for localization purposes. This functionality is
        only partially implemented and not actually visible in the client.    	    	

        modules
        =======================================================================       
            This is where the bulk of application functionality may be found.
        Each module generally focuses on a specific aspect of functionality.

        templates
        =======================================================================   
            Contains individual files, each of which extend the 'Templates' 
        namespace within the framework. These files contain functions for 
        generating snippets of dynamically inserted html.
