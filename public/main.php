<?php	

date_default_timezone_set('America/Toronto');


//error reporting
// ini_set('error_reporting',E_ALL ^ (E_NOTICE | E_WARNING | E_DEPRECATED));
error_reporting(-1);

//makes the URL neat and small
$_SERVER["PHP_SELF"]  = basename($_SERVER["PHP_SELF"]);

//Paths to inportant system files
define('ROOT', dirname(dirname(__FILE__)));

//default values
define ('DEFAULT_CONTROLLER','home');
define ('DEFAULT_METHOD','index');

function myAutoLoader ($className) {

    $classFile = strtolower($className) . '.php';
    
    $locations = array(
        	'/system/classes/',
          '/application/controllers/',
          '/application/models/');
        
        foreach($locations as $location)
        {
            $file = ROOT . $location.$classFile;
            if(file_exists($file)){
                require_once($file);
                return;
            }            
        }

 		trigger_error("Controller file $classFile.php could not be lazy loaded");
 }

// Set function for use as autoloader
spl_autoload_register('myAutoLoader');

//Eager load all configuration files
 foreach (glob(ROOT.'/application/config/*.php') as $filename) {
     require_once $filename;
 }

$GLOBALS['config'] =& $config;

$requestStr = json_decode(file_get_contents('php://input'),true);

foreach ($requestStr['api'] as $controller => $methods) {

	$controllerName = ($controller == 'default' ? DEFAULT_CONTROLLER : $controller);	

	$controllerName = ucfirst($controllerName);
	$controllerObj = new $controllerName; 

	foreach ($methods as $method => $args) {

		$method = ($method == 'default' ? DEFAULT_METHOD : $method);	

		if (method_exists($controllerObj, $method)) {
			 call_user_func(array($controllerObj,$method),$args);
		} else {
			 trigger_error("Non-existent  method has been called: $controllerName, $method");
		}
	}
}


