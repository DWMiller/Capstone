<?php 	

class Admin extends Controller {
	
	private $admin;

	 function __construct() {
		  parent::__construct();
		  $this->admin = new Admin_m;
	}
	
	function index () {
		$this->output->json_response($this->TPL);
	}

	public function clear() {
		$this->admin->clearExpiredSessions();
	}
}
