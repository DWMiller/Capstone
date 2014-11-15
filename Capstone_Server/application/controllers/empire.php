<?php 	

class Empire extends Core_Controller {
	// private $Game;
	// private $Auth;
	private $Users;

	private $user;

	function __construct() {
		parent::__construct();
		// $this->Game = new Game_m;
		// $this->Auth = new userauth_m(); 
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
		$cost;
		switch($type) {
			case 'shipyard':
				$cost = $location->getShipyardUpgradeCost();
				break;
			case 'mine':
				$cost = $location->getMineUpgradeCost();
				break;
			case 'lab':
				$cost = $location->getLabUpgradeCost();
				break;
		}

		if($this->user['resources'] < $cost) {
			return;
		}

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

		$this->Users->removeResources($this->user['id'],$cost);
		$this->user['resources'] -= $cost;

		// if($result) {
			$this->TPL['user-update'] = $this->user;
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
