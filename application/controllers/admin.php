<?php 	

class Admin extends Controller {
	
	private $Auth;
	private $admin;
	private $map;

	function __construct() {
		parent::__construct();
		$this->admin = new Admin_m;
		$this->Auth = new userauth_m(); 

		$this->map = new Map_m;

		$this->TPL['user'] = $this->Auth->loggedIn();		
		if(!$this->TPL['user']) {
			exit;
		}		  
	}
	
	function index () {
		$this->output->json_response($this->TPL);
	}

	public function clear() {
		$this->admin->clearExpiredSessions();
	}

	public function new_game() {
		$args = func_get_args()[0];

		$this->admin->activateQueuedPlayers();
		$this->admin->createNewGame($args['player_count']);
		// $this->admin->placePlayers();
	}

	public function end_game() {
		$this->admin->deleteCurrentGame();
		$this->admin->clearActivePlayers();
	}

	public function generate() {
		$args = func_get_args()[0];

		$this->map->eraseMap();
		$this->map->createMap($args['scale'],$args['seed']);
	}
}
