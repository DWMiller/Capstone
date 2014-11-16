<?php 	

class Admin extends Core_Controller {

	private $admin;
	private $map;

	function __construct() {
		parent::__construct();
		$this->admin = new Admin_m;

		if(!$this->User) {
			exit;
		}

		if(!$this->User['is_admin']) {
			exit;
		}

		$this->map = new Map_m;
	}
	
	function index () {
		$this->output->json_response($this->TPL);
	}

	public function new_game() {
		$args = func_get_args()[0];

		//Comment out when live
		$this->admin->queueAllPlayers();
		
		$playerCount = $this->admin->activateQueuedPlayers();

		if($playerCount >= MIN_PLAYERS) {
			$this->admin->createNewGame();//$args['player_count']

			//Don't change scale, equates to dimensions of map and values other than 1000 are not currently supported
			$this->admin->createMap(1000, 25*$playerCount);
			$this->admin->placePlayers();			
		} else {
			$this->end_game();
		}

	}

	public function end_game() {
		$this->admin->deleteCurrentGame();
		$this->admin->eraseFleets();
		$this->admin->eraseBattleLogs();
		$this->admin->eraseMap();
		$this->admin->clearActivePlayers();
	}
}
