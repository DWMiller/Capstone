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
		$this->admin->activateQueuedPlayers();
		$this->admin->createNewGame();
		$this->admin->placePlayers();
	}

	public function end_game() {
		$this->admin->deleteCurrentGame();
		$this->admin->clearActivePlayers();
	}


	public function generate() {

		// $map->createMap($_POST['scale'],$_POST['seed']);
	}

}
