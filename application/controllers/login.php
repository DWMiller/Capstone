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
		$args = func_get_args()[0];
		$user = $this->Auth->login($args['email'],$args['password']);

		if($user) {
			$this->TPL['login-success']['user'] = $user;
		} else {
			$this->TPL['login-failure'] = true;
		}


		$this->output->json_response($this->TPL);
	}

 } 


