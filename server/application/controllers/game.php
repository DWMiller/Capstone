<?php 	

class Game extends Core_Controller {
	private $game;
	private $users;

	function __construct() {
		parent::__construct();
		$this->game = new Game_m;
		$this->users = new Users_m;	

		$this->requireAuthentication();
	}
	
	function index () {
		// $game = $this->game->getCurrentGame();
		// $this->TPL['game-update']['game'] = $game;
		// $this->done();
	}

	/**
	 * Sign the user up for the next available game
	 * @return [type] [description]
	 */
	function join_queue() { 
		if($this->User['status'] == USER_IDLE) {
			$this->users->joinQueue($this->User);
		}

		$this->TPL['queue-update']['user-status'] = $this->User['status'];
		$this->done();
	}

	/**
	 * Remove used from queue for next game
	 * @return [type] [description]
	 */
	function leave_queue() { 
		if($this->User['status'] == USER_QUEUED) {
			$this->users->leaveQueue($this->User);
		}

		$this->TPL['queue-update']['user-status'] = $this->User['status'];
		$this->done();
		
	}

	/**
	 * Checks for any game updates of relevance to the player
	 * @return [type] [description]
	 */
	function update() {
		$this->TPL['queue-update']['user-status'] = $this->User['status'];
		$this->done();
	}

	function done() {
		$this->output->json_response($this->TPL);
	}

}
