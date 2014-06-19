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

	public function new_game() {
		$this->admin->createNewGame();
	}

	public function end_game() {
		$this->admin->deleteCurrentGame();
	}


}
