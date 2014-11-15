<?php
function myAutoLoader ($className) {

    $classFile = strtolower($className) . '.php';
    
      $locations = array(
          '/system/classes/',
          '/application/core/',
          '/application/controllers/',
          '/application/models/',
          '/application/classes/geometry/',
          '/application/classes/map/');
        
        foreach($locations as $location)
        {
            $file = ROOT . $location.$classFile;
            if(file_exists($file)){
                require_once($file);
                return;
            }            
        }

 		trigger_error("Controller file $classFile could not be lazy loaded");
 }