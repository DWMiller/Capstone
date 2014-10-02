<?php 
/************************ Functions **********************************************/
function errorHandler($errno, $errstr, $errfile, $errline)
{
    $TPL = array(   'errorNumber'       => $errno,
                'errorMessage'      => $errstr,
                'errorLineNumber'   => $errline,
                'errorFileName'     => $errfile,
                'time'              => date("F j, Y, g:i a"));
                
    echo '<pre>';
    echo print_r($TPL,true);
    echo '</pre>';
    exit;
}

function myAutoLoader ($className) 
{

    $classFile = strtolower($className) . '.php';
    
    $dir = array(
        	'/system/classes/',
          '/application/controllers/',
          '/application/models/',
          '/application/classes/geometry/',
          '/application/classes/map/');
        
        foreach($dir as $location) {
            $file = ROOT . $location.$classFile;
            if(file_exists($file)){
                require_once($file);
                return;
            }            
        }

 		trigger_error("Controller file $classFile could not be lazy loaded");
 }

// function parsePrettyPath()
// {
//   // Parse pretty URL into params
//   $url = explode('?', $_SERVER['REQUEST_URI']);
//   if (count($url) == 2)
//   {
//     $params = explode('/', $url[1]);
//     array_shift($params);

//     if (count($params) >= 1)
//     {
//       $vars = array();
      
//       $_REQUEST["c"] = array_shift($params);
//     }

//     if (count($params) >= 1)
//     {
//       $_REQUEST["m"] = array_shift($params);
//       $_REQUEST['args'] = &$params; 
//     }
//   }
// }