<?php 	

class Empire extends Core_Controller {
	private $Users;

	function __construct() {
		parent::__construct();
		$this->Users = new Users_m;	
		$this->requireAuthentication();
	}
	
	function upgrade() {
		$args = func_get_args();
		$args = $args[0];

		$location = new Location_m($args['location']);

		if(!$location->isOwner($this->User)) {
			$this->addError('Invalid Request', 'This location does not belong to you.');
			$this->TPL['structure-upgrade-failure'] = $this->errors;
			$this->output->json_response($this->TPL);
		}

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
			$this->addError('Insufficient Funds', '');
			$this->TPL['structure-upgrade-failure'] = $this->errors;
			$this->output->json_response($this->TPL);
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
			$this->TPL['user-update'] = output_filters::userData($this->User);
			$this->TPL['location-update'] = $location->data;
			$this->output->json_response($this->TPL);
		// }
	}

	function research() {
		$args = func_get_args();
		$args = $args[0];

		$type = $args['type']; //armour, weapons , propulsion

		$cost;
		switch($type) {
			case 'weapons':
				$cost = 10 + ($this->User['tech_weapons']+1) * 10;
				break;
			case 'armour':
				$cost = 10 + ($this->User['tech_armour']+1) * 10;
				break;
			case 'propulsion':
				$cost = 10 + ($this->User['tech_propulsion']+1) * 10;
				break;
		}

		if($this->User['knowledge'] < $cost) {
			return;
		}

		$result;
		switch($type) {
			case 'weapons':
				$result = $this->Users->researchWeapons($this->User['id']);	
				$this->User['tech_weapons']++;			
				break;
			case 'armour':
				$result = $this->Users->researchArmour($this->User['id']);
				$this->User['tech_armour']++;
				break;
			case 'propulsion':
				$result = $this->Users->researchPropulsion($this->User['id']);
				$this->User['tech_propulsion']++;					
				break;
		}

		$this->Users->removeKnowledge($this->User['id'],$cost);
		$this->User['knowledge'] -= $cost;

		$this->TPL['user-update'] = output_filters::userData($this->User);

		$this->output->json_response($this->TPL);

	}

	function rename() {
		$args = func_get_args();
		$args = $args[0];

		$location = new Location_m($args['location']);	

		if(!$location->isOwner($this->User)) {
			$this->TPL['location-rename-failure'] = true;
			$this->output->json_response($this->TPL);
		}

		$name = Validator::locationName($args['name']) ? $args['name'] : false;

		if(!$name) {
			$this->TPL['location-rename-failure'] = true;
			$this->output->json_response($this->TPL);				
		}
		
		$result = $location->rename($name);
		$this->TPL['location-update'] = $location->data;	
		$this->output->json_response($this->TPL);		
	}
}
