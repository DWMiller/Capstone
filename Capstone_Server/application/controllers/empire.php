<?php 	

class Empire extends Core_Controller {
	// private $Game;
	private $Users;

	function __construct() {
		parent::__construct();
		// $this->Game = new Game_m;
		$this->Users = new Users_m;	

		if(!$this->User) {
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

		if($this->User['resources'] < $cost) {
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

		$this->Users->removeResources($this->User['id'],$cost);
		$this->User['resources'] -= $cost;
		$location->calcUpgradeCosts();

		// if($result) {
			$this->TPL['user-update'] = $this->filteredUserData();
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
