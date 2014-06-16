<?php	

session_start();
if (!isset($_SESSION['startTimeOfSession'])){$_SESSION['startTimeOfSession'] = time();}

//error reporting
ini_set('error_reporting',E_ALL ^ (E_NOTICE | E_WARNING | E_DEPRECATED));

//makes the URL neat and small
$_SERVER["PHP_SELF"]  = basename($_SERVER["PHP_SELF"]);

//Paths to inportant system files
define('ROOT', dirname(dirname(__FILE__)));
define('ERRORHANDLER_VIEW',ROOT.'/system/errorPages/errorHandler.view.php');
define('DATABASEERROR_VIEW',ROOT.'/system/errorPages/dataBaseError.view.php');

define('LOGFILE',ROOT.'/system/logFiles/logfile.txt');

//default values
define ('DEFAULT_CONTROLLER','home');
define ('DEFAULT_METHOD','index');

//Eager load all configuration files
 foreach (glob(ROOT.'/system/config/*.php') as $filename) {
     require_once $filename;
 }

$GLOBALS['config'] =& $config;


//General and program errors reported here....
set_error_handler('errorHandler',E_ALL ^ (E_NOTICE | E_WARNING | E_DEPRECATED));

// Set function for use as autoloader - defined in config/functions.php
spl_autoload_register('myAutoLoader');

parsePrettyPath(); // Converts path into control parameters - defined in config/functions.php

//default conditions
$controllerName = (isset($_REQUEST["c"]) and empty($_REQUEST["c"]) == false )
					?  $_REQUEST["c"] : DEFAULT_CONTROLLER;
$methodName 	= (isset($_REQUEST["m"]) and empty($_REQUEST["m"]) == false )
					?  $_REQUEST["m"] : DEFAULT_METHOD;
 
//Class name is firstletter in capitol letters
$controllerName = ucfirst($controllerName);
//Instantiate controller class. Shouldn't fail, since we checked in auto_load
$controllerObj = new $controllerName; 

//call controller and method 
if (method_exists($controllerObj, $methodName))
{
	 call_user_func(array($controllerObj,$methodName));
} else {
	 trigger_error("Non-existent  method has been called: $controllerName, $methodName");
}
 




