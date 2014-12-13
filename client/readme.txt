Capstone/client
===============================================================================
    This is the root of the client application.

    The client application is written entirely in HTML, CSS and JavaScript, and
exists entirely as a single web page. These aspects allow very high portability client code implementations, supporting potential adaptations to other platform such as smartphone apps.

    Framework
    ===========================================================================
        The client application has been developed using a custom JavaScript 
    framework. This framework is quite limited in overall functionality, 
    and exists primarily to support a more modular and structured approach
    to writing code in JavaScript.

        For reference: https://github.com/DWMiller/custom_js_framework

    Notable Tools Utilized
    ===========================================================================

            SASS: SASS (http://sass-lang.com) is a CSS pre-processing language, 
        allowing CSS to be written more like a programming language.
    
            Grunt: Grunt (http://gruntjs.com/) is an automated task manager 
        developed in nodeJS. It’s potential usage and even it’s implementation 
        in this project rather extensive, but in simplest terms I am using it 
        as a compiler.

            KineticJS: KineticJS (http://kineticjs.com) is a library intended 
        to ease development utilizing complicated canvas tag functionality. 
        Overall, it may have been more trouble than it was worth, and is 
        primarily being used to simulate events such as ‘click’ and ‘mouseover’ 
        on individual canvas images, like planets.

    Deployment
    ===========================================================================
        The latest build is ready to go. The best option at this stage is to 
    simply run the prepared ‘Launch Capstone.bat’ file located in main
    directory of the USBWebServer. This script will attempt to start the web 
    server and launch the client url within the Chrome browser.

        If you make changes to the client and desire to see them incorporated 
    into the live game, that's a different story. Compiling the code is not
    overly difficult, but requires various unrelated configuration steps on the
    computer being used. Consequently, that process will not be documented here.

        If you really want to make changes, I may be contacted for inquiries on
    the process. Alternatively, you may skip this process and edit the 
    compiled filed directly in the client/dist directory. Changes to these files
    will be live, but are much more difficult to navigate as for example, all
    javascript files are merged into a single file thousands of lines in length.

    Subdirectories
    ===========================================================================
 
        assets
        =======================================================================  
            This directory contains all images used in the project

        dist
        ======================================================================= 
            This is the production directory, created programatically by Grunt. 
        The files in this directory are the ones utilized when viewing the site.
        These files should not be altered manually. 

        grunt
        ======================================================================= 
            This directory contains the tasks to be executed by Grunt in the 
        compilation process which creates the files in the dist directory. 
        These files will not be documented within this project.

        js
        =======================================================================    
           This directory contains all JavaScript files utilized in this
        application, and is thus where most functionality may be found.

        Sass
        =======================================================================    
            This directory contains all the SASS files for the project. These
        files are generally similar enough to standard CSS to be read as such.                  