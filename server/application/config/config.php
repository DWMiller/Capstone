<?php
function myAutoLoader ($className) {

    $classFile = strtolower($className) . '.php';
    
      $locations = array(
          '/system/classes/',
          '/application/helpers/',
          '/application/core/',
          '/application/controllers/',
          '/application/models/',
          '/application/generation/');
        
        foreach($locations as $location){
            $file = ROOT.$location.$classFile;
            
            if(file_exists($file)){
                require_once($file);
                return;
            }            
        }

 		trigger_error("Controller file $classFile could not be lazy loaded");
 }

 define('SESSION_LIMIT',2000); 