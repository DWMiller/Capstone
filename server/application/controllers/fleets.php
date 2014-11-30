<?php 	

class Fleets extends Core_Controller {
	private $Users;

	function __construct() {
		parent::__construct();

		$this->Users = new Users_m;	

		$this->requireAuthentication();
	}
	
	function move() {
		$args = func_get_args();
		$args = $args[0];

		if(!is_array($args['fleet'])) {
			$args['fleet'] = array($args['fleet']);
		}

		$fleets = array();
		foreach ($args['fleet'] as $fleet) {
			// TODO - Validate fleet actually exists
			$fleet = new Fleet_m($fleet);

			//Ensure user actually owns fleet(s)
			if($fleet->data['owner_id'] != $this->User['id']) {
				$this->addError('Fleet movement failed', 'You do not own this fleet');
				$this->TPL['fleet-movement-error'] = $this->errors;
				$this->output->json_response($this->TPL);
			}

			$fleets[] = $fleet;
		}

		// Get target location
		$targetLocation = new Location_m($args['target']);
		//TODO - make sure movement is possible according to game rules

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
