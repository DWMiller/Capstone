<?php	

// echo '<pre>';
// echo print_r($_REQUEST['game'],true);
// echo '</pre>';

date_default_timezone_set('America/Toronto');

//error reporting
//ini_set('error_reporting',E_ALL ^ (E_NOTICE | E_WARNING | E_DEPRECATED));
error_reporting(-1);

//makes the URL neat and small
$_SERVER["PHP_SELF"]  = basename($_SERVER["PHP_SELF"]);

//Paths to inportant system files
define('ROOT', dirname(dirname(__FILE__)));

define('LOGFILE',ROOT.'/system/logFiles/logfile.txt');

//default values
define ('DEFAULT_CONTROLLER','home');
define ('DEFAULT_METHOD','index');

//Eager load all configuration files
 foreach (glob(ROOT.'/system/config/*.php') as $filename) {
     require_once $filename;
 }

//$GLOBALS['config'] = &$config;

//General and program errors reported here....
set_error_handler('errorHandler',E_ALL ^ (E_NOTICE | E_WARNING | E_DEPRECATED));

// Set function for use as autoloader - defined in config/functions.php
spl_autoload_register('myAutoLoader');

parsePrettyPath(); // Converts path into control parameters - defined in config/functions.php

//default conditions

foreach ($_REQUEST['game'] as $controller => $methods) {

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




