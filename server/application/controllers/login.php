<?php 

/**
 * 
 */
 class Login extends Core_Controller {
	private $users;

	function __construct() {
		parent::__construct();
		$this->users = new Users_m;		  
	}

	function login () {
		$args = func_get_args();
		$args = $args[0];

		$this->User = $this->Auth->login($args['email'],$args['password']);

		if(!$this->User) {
			$this->addError('Login failed', '');
		}
			
		$this->done();
	}

	function logout () {
		$this->requireAuthentication();	
		$this->Auth->logout($this->User['id']);
		exit;
	}

	function done() {
		if (count($this->errors) > 0) {
			$this->TPL['login-failure'] = $this->errors;
		} else {
			$this->TPL['login-success']['user'] = $this->User;
		}

		$this->output->json_response($this->TPL);	
	}
 }