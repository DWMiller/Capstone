Capstone/server/application
===============================================================================
        This is the container for code developed for this application.

    Subdirectories
    ===========================================================================
 
        config
        =======================================================================  
            Contains files to always be loaded by the framework, these files
        generally define variables to be used globally in the application.

        controllers
        =======================================================================  
            This directory contains the application controllers. The files
        within are the endpoints for any api requests, and generally serve to 
        categorize and handle functionality specific to certain aspects of the 
        game.

        core
        =======================================================================  
            This directory is used for very little due to advancements in
        the framework which made many of the existing functions obsolete.

            In theory, this class serves to establish base classes to be
        inherited by controllers and models, allowing common functionality, such
        as authentication within a controller, to be abstracted out into a 
        common location.

        generation
        ======================================================================= 
            This directory contains the classes used in the generation of game
        maps, only utilized by the admin model at this time.

        helpers
        =======================================================================  
            Contains Classes intended to be used in a static context, providing 
        general purpose utility functions, to be used on an as needed basis
        throughout the application.

        models
        =======================================================================  
            Instansiated and utilized only be controllers, models handle the 
        more specialized application logic. All models inherit database 
        connectivity, and some models exist to represent database objects,
        inheriting basic ORM functionality from the framework.

            The bulk of the 'dirty work' is handled within these files.

        scripts
        =======================================================================
            This directory contains various backup .sql scripts. Generally, 
        these scripts will fall into two categories, either generic complete
        backups of the database, or backups of specific game states to be used 
        in the exectution of tests.
