<?php 

/*=============================================================================
	Handles the registration of new accounts
/*===========================================================================*/
 class Register extends Core_Controller {
 	
 	private $users;

	function __construct() {
		  parent::__construct();
		  $this->users = new Users_m;
	}

	/**
	 * A request to create a new account
	 * @return [type] [description]
	 */
	public function register () {
		$args = func_get_args();
		$args = $args[0];

		//Is password valid? 
		$password = Validator::password($args['password']) ? $args['password'] : false;

		if(!$password) {
			$this->addError('Registration failed', 'Password must not be empty.');
			$this->done();
		}

		//Is email valid? 
		$email = Validator::email($args['email']) ? $args['email'] : false;

		if(!$email) {
			$this->addError('Registration failed', 'Provided email is not valid.');
			$this->done();
		}

		// Is email available?
		$users = $this->users->getUsersByField($email,'email');

		if($users) {
			$this->addError('Registration failed', 'Email already in use.');
			$this->done();
		} 

		$result =  $this->users->createUser($email,$password);

		if(!$result) {
			$this->addError('Registration failed', 'Unkown error: Account could not be created');
		}
		
		$this->done();
	}

	private function done() {
		if (count($this->errors) > 0) {
			$this->TPL['register-failure'] = $this->errors;
		} else {
			$this->TPL['register-success'] = true;
		}

		$this->output->json_response($this->TPL);
	}



 } 



