Capstone/server/application/controllers
===============================================================================
    This directory contains the application controllers. The files
within are the specific endpoints for any api requests, and generally serve to 
categorize and handle functionality specific to certain aspects of the 
game.

    All controllers inherit the Core_Controller class, found in 
Capstone/server/application/core. This inherited class grants authentication
logic to all controllers, checking for a logged in user and providing access
filters that require a user to be authenticated or an adminstrator.
   