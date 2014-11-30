<?php 	

class Admin extends Core_Controller {

	private $admin;
	private $map;

	function __construct() {
		parent::__construct();
		$this->admin = new Admin_m;

		$this->requireAuthentication();
		$this->requireAdmin();

		$this->map = new Map_m;
	}
	


	public function new_game() {
		//Comment out when live
		$this->admin->queueAllPlayers();
		
		$playerCount = $this->admin->activateQueuedPlayers();

		if($playerCount < MIN_PLAYERS) {
			$this->addError('Insufficient Players', '');
			$this->TPL['game-start-failure'] = $this->errors;
			$this->output->json_response($this->TPL);			
		}

		$this->admin->createNewGame($playerCount);

		//Don't change MAP_SIZE, equates to dimensions of map and values other than 1000 are not currently supported
		$this->admin->createMap(MAP_SIZE, $playerCount);
		$this->admin->placePlayers();

		$this->TPL['game-start-success'] = 'Game started with '.$playerCount.' players';
		$this->output->json_response($this->TPL);	
	}

	public function end_game() {
		$this->admin->deleteCurrentGame();
		$this->admin->eraseFleets();
		$this->admin->eraseBattleLogs();
		$this->admin->eraseMap();
		$this->admin->clearActivePlayers();
	}
}
