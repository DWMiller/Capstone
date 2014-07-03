<?php 	

class Game extends Controller {
	private $game;
	private $Auth;
	private $users;

	function __construct() {
		parent::__construct();
		$this->game = new Game_m;
		$this->Auth = new userauth_m(); 
		$this->users = new Users_m;	

		$this->TPL['user'] = $this->Auth->loggedIn();		
		if(!$this->TPL['user']) {
			exit;
		}
	}
	
	function index () {
		$this->output->json_response($this->TPL);
	}

	/**
	 * Sign the user up for the next available game
	 * @return [type] [description]
	 */
	function join_queue() { 
		$this->users->joinQueue($this->TPL['user']['id']);
	}

	/**
	 * Remove used from queue for next game
	 * @return [type] [description]
	 */
	function leave_queue() { 
		$this->users->leaveQueue($this->TPL['user']['id']);
	}

}










