<?php 

/**
 * 
 */
 class Register extends Controller
 {
 	private $users;

	 function __construct() {
		  parent::__construct();
		  $this->users = new Users_m;
	}

	function index () {
		$args = func_get_args()[0];

		$users = $this->users->getUsersByField($args['email'],'email');

		if($users) {
			// If user was found with this email, user already has account
			$this->TPL['register-failure'] = true;
		} else {
			$result =  $this->users->createUser($args['email'],$args['password']);
			if($result) {
				$this->TPL['register-success'] = true;
			} else {
				$this->TPL['register-failure'] = true;
			}
		}
		$this->output->json_response($this->TPL);
	}

 } 


