<?php 

/**
 * 
 */
 class Logout extends Controller {
 	private $Auth;
	private $users;

	function __construct() {
		parent::__construct();
		$this->Auth = new userauth_m(); 
		$this->users = new Users_m;		  
	}

	function index () {	
		$this->Auth->logout();
		$this->output->json_response($this->TPL);
	}

 } 


