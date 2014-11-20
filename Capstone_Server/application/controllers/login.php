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

	function index () {
		$args = func_get_args()[0];
		$this->User = $this->Auth->login($args['email'],$args['password']);

		if($this->User) {
			$this->TPL['login-success']['user'] = $this->User;
			// $this->TPL['login-success']['locations'] = Location_m::getPlayerLocations($this->User['id']);
		} else {
			$this->TPL['login-failure'] = true;
		}

		$this->done();
	}

	function logout () {	
		$this->Auth->logout($this->User['id']);
		$this->done();
	}

	function done() {
		$this->output->json_response($this->TPL);	
	}
 }