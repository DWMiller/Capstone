<?php 

/**
 * 
 */
 class Register extends Controller
 {
	 function __construct() {
		  parent::__construct();
	}

	function index () {
		$users = new Users_m;


		$result = $users->createUser($_REQUEST['email'],$_REQUEST['password']);

		if($result) {

		} else {
			
		}

		$this->TPL['result'] = $result;
		
		$this->output->json_response($this->TPL);
	}

 } 


