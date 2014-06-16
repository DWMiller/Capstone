<?php 
/************************ Functions **********************************************/
function errorHandler($errno, $errstr, $errfile, $errline)
{
    $TPL = array(   'errorNumber'       => $errno,
                'errorMessage'      => $errstr,
                'errorLineNumber'   => $errline,
                'errorFileName'     => $errfile,
                'time'              => date("F j, Y, g:i a"));
                
    include ERRORHANDLER_VIEW;   
    exit;
}

function myAutoLoader ($className) 
{

    $classFile = strtolower($className) . '.php';
    
    $locations = array(
          '/application/controllers/',      
        	'/system/classes/',
          '/application/classes/map/',
          '/application/models/',
          '/system/libs/geometry/');
        
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

function parsePrettyPath()
{
  // Parse pretty URL into params
  $url = explode('?', $_SERVER['REQUEST_URI']);
  if (count($url) == 2)
  {
    $params = explode('/', $url[1]);
    array_shift($params);

    if (count($params) >= 1)
    {
      $vars = array();
      
      $_REQUEST["c"] = array_shift($params);
    }

    if (count($params) >= 1)
    {
      $_REQUEST["m"] = array_shift($params);
      $_REQUEST['args'] =& $params; 
    }
  }
}