<?php 

/**
 * 
 */
 class Login extends Controller {
 	private $Auth;
	private $users;

	function __construct() {
		parent::__construct();
		$this->Auth = new userauth_m(); 
		$this->users = new Users_m;		  
	}

	function index () {	
		$this->TPL['user'] = $this->Auth->login($_POST['email'],$_POST['password']);
		$this->output->json_response($this->TPL);
	}

 } 


