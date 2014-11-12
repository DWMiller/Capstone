<?php 	

class Empire extends Controller {
	// private $Game;
	private $Auth;
	private $Users;

	private $user;

	function __construct() {
		parent::__construct();
		// $this->Game = new Game_m;
		$this->Auth = new userauth_m(); 
		$this->Users = new Users_m;	

		$this->user = $this->Auth->loggedIn();
		if(!$this->user) {
			exit;
		}
	}
	
	function upgrade() {
		$args = func_get_args()[0];

		$location = new Location_m($args['location']);
		$type = $args['type']; //mine/shipyard/lab

		//calculate costs
		$result;
		switch($type) {
			case 'shipyard':
				$result = $location->upgradeShipYard(1);
				break;
			case 'mine':
				$result = $location->upgradeMine(1);
				break;
			case 'lab':
				$result = $location->upgradeLab(1);
				break;
		}

		// if($result) {
			$this->TPL['location-update'] = $location->data;
			$this->output->json_response($this->TPL);
		// }
	}

	function rename() {
		$args = func_get_args()[0];
		$location = new Location_m($args['location']);	
		$name = $args['name'];		

		$result = $location->rename($name);
		$this->TPL['location-update'] = $location->data;
		$this->output->json_response($this->TPL);		
	}

}
