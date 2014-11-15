<?php 	

class Game extends Core_Controller {
	private $game;
	// private $Auth;
	private $users;

	private $user;

	function __construct() {
		parent::__construct();
		$this->game = new Game_m;
		// $this->Auth = new userauth_m(); 
		$this->users = new Users_m;	

		$this->user = $this->Auth->loggedIn();
		if(!$this->user) {
			exit;
		}
	}
	
	function index () {
		$game = $this->game->getCurrentGame();
		$this->TPL['game-update']['game'] = $game;

		$this->output->json_response($this->TPL);
	}

	/**
	 * Sign the user up for the next available game
	 * @return [type] [description]
	 */
	function join_queue() { 
		if($this->user['status'] == USER_IDLE) {
			$this->users->joinQueue($this->user);
		}

		$this->TPL['queue-update']['user-status'] = $this->user['status'];
		$this->output->json_response($this->TPL);
	}

	/**
	 * Remove used from queue for next game
	 * @return [type] [description]
	 */
	function leave_queue() { 

		if($this->user['status'] == USER_QUEUED) {
			$this->users->leaveQueue($this->user);
		}

		$this->TPL['queue-update']['user-status'] = $this->user['status'];
		$this->output->json_response($this->TPL);
	}

	/**
	 * Checks for any game updates of relevance to the player
	 * @return [type] [description]
	 */
	function update() {

	}

}
