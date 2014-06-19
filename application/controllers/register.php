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
		
		$result =  $this->users->createUser($_REQUEST['email'],$_REQUEST['password']);

		$this->TPL['result'] = $result;
		
		$this->output->json_response($this->TPL);
	}

 } 


