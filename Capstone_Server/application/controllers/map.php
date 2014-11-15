<?php 	

class Map extends Core_Controller {
		
	private $map;	
	// private $Auth;
	private $users;
	private $user;

	function __construct() {
		parent::__construct();

		$this->map = new Map_m();

		// $this->Auth = new userauth_m(); 
		$this->users = new Users_m;	

		$this->user = $this->Auth->loggedIn();
		if(!$this->user) {
			exit;
		}

	}
	
	function index () {
		$this->done();
	}

	function universe () {
		$args = func_get_args()[0];
		$this->done();
	}

	function galaxy () {
		$args = func_get_args()[0];
		$this->done();
	}

	function sector () {	
		$args = func_get_args()[0];

		$this->TPL['map-update']['systems'] = $this->map->getSystems($args['id']);

		$fleets = Fleet_m::getWormholeFleets($args['id']);

		foreach ($fleets as $key => $fleet) {
			$fleet = new Fleet_m($fleet['id'], $fleet);
			$fleets[$key] = $fleet->data;
		}

		$this->TPL['map-update']['fleets'] = $fleets;

		$this->done();
	}

	function system () {
		$args = func_get_args()[0];

		$locations = $this->map->getLocations($args['id']);

		foreach ($locations as $key => $location) {
			$location = new Location_m($location['id'], $location);
			$location->data['upgrade-cost-mine'] = $location->getMineUpgradeCost();
			$location->data['upgrade-cost-shipyard'] = $location->getShipyardUpgradeCost();
			$location->data['upgrade-cost-lab'] = $location->getLabUpgradeCost();
			$locations[$key] = $location->data;
		}

		$this->TPL['map-update']['locations'] = $locations;

		$fleets = Fleet_m::getSystemFleets($args['id']);

		if($fleets) {
			foreach ($fleets as $key => $fleet) {
				$fleet = new Fleet_m($fleet['id'], $fleet);
				$fleets[$key] = $fleet->data;
			}
		}

		$this->TPL['map-update']['fleets'] = $fleets;
		$this->done();
		
	}			

	function done() {
		$this->TPL['user-update'] = $this->user;
		$this->output->json_response($this->TPL);
	}

}
