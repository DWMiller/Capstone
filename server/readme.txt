Capstone/server
===============================================================================
        This is the root of the server application, developed in PHP.
    This application is strictly an API, it handles JSON formatted JavaScript
    objects as input, and returns JSON formatted PHP arrays in response.

        If you are only viewing this documentation for the purposes of client
    development, it is recommended you go directly to the apidocs (see below).

    Framework
    ===========================================================================
        The server application is developed using a very lightweight custom
        framework. 

        For reference: https://github.com/DWMiller/custom_php_framework

    Deployment
    ===========================================================================
        No extra steps are required to deploy the back end application, 
    the code will run as is. However, if you are not running the application
    on the provided, pre-prepared UsbWebServer, or have somehow corrupted the 
    database, you will need to import a database backup script.

        The scripts themselves can be found within the application/scripts,
    any script in this directory will work for this purpose.

        To import this script, the simplest method to document is using
    phpMyAdmin, which can be found here: http://localhost:8080/phpmyadmin/ when
    the web server is running.

    Username: root
    Password: usbw
    Port: 3307 (needed if you choose to connect to the database another way)

        Once logged in, simply navigate to the import tab, select 'Choose File'
    within the 'File to Import' section, pick one of the .sql files provided and
    click 'Go'. Now you're read to go.

    Subdirectories
    ===========================================================================
 
        apidocs
        =======================================================================  
            This directory contains the prepared api documentation. This 
        documentation is an ajax dependent website itself, and to be 
        properly viewed will need to be accessed with the web server running.

            With the web server active, navigate to 
        http://localhost:8080/Capstone/ Here you will find links to either view
        the client or view the api documentation.

        application
        =======================================================================  

        public
        ======================================================================= 
            This is the publically asscessible directory of the framework, 
        it contains only the main.php file and is the only endpoint for all API 
        requests. 

            Documentation standards of this project will not persist into this
        directory, as the framework is merely utilized by this project, not
        created as a component of it.

        system
        =======================================================================    
            This is the container for all framework classes

            Documentation standards of this project will not persist into this
        directory, as the framework is merely utilized by this project, not
        created as a component of it.                      