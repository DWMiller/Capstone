<?php 	

class Fleets extends Core_Controller {
	private $Users;

	function __construct() {
		parent::__construct();

		$this->Users = new Users_m;	

		if(!$this->User) {
			exit;
		}
	}
	
	function move() {
		$args = func_get_args()[0];
		$targetLocation = new Location_m($args['target']);

		if(!is_array($args['fleet'])) {
			$args['fleet'] = array($args['fleet']);
		}

		$fleets = array();
		foreach ($args['fleet'] as $fleet) {
			// TODO - Validate fleet actually exists
			$fleets[] = new Fleet_m($fleet);
		}

		// Maybe figure out how to move all fleets in a single query
		foreach ($fleets as $fleet) {

			if(!$fleet->data['destination_id']) {

				if(isset($args['split']) && $args['splitSize'] < $fleet->data['size']) {
					$newFleetId = $fleet->splitMove($targetLocation, $args['splitSize'],$this->User['tech_propulsion']);
					$this->TPL['fleet-update'][] = $fleet->getFleetData($newFleetId);
					$this->TPL['fleet-update'][] = $fleet->getFleetData($fleet->data['id']);
				} else {
					$fleet->move($targetLocation,$this->User['tech_propulsion']);
					$this->TPL['fleet-update'][] = $fleet->getFleetData($fleet->data['id']);
				}
				
				
			}
		}


		// $fleet = new Fleet_m($args['fleet']);
		
		// $fleet->move($targetLocation);

		// $this->TPL['fleet-update'] = $fleet->getFleetData($fleet->data['id']);
		$this->output->json_response($this->TPL);
	}
}
