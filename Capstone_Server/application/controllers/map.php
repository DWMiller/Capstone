<?php 	

class Map extends Core_Controller {
		
	private $map;	
	private $users;

	function __construct() {
		parent::__construct();

		$this->map = new Map_m();
		$this->users = new Users_m;	

		if(!$this->User) {
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

		if($fleets) {
			foreach ($fleets as $key => $fleet) {
				$fleet = new Fleet_m($fleet['id'], $fleet);
				$fleets[$key] = $fleet->data;
			}
		}

		$this->TPL['map-update']['fleets'] = $fleets;


		$sectorLocationSummary = Location_m::getSectorLocations($args['id']);
		if($sectorLocationSummary) {
			$this->TPL['map-update']['systemLocations'] =$sectorLocationSummary;
		}


		$sectorFleetSummary = Fleet_m::getSectorFleets($args['id']);
		if($sectorFleetSummary) {
			$this->TPL['map-update']['systemFleets'] = $sectorFleetSummary;
		}

		$this->done();
	}

	function system () {
		$args = func_get_args()[0];

		$locations = $this->map->getLocations($args['id']);

		foreach ($locations as $key => $location) {
			$location = new Location_m($location['id'], $location);
			// $location->data['upgrade-cost-mine'] = $location->getMineUpgradeCost();
			// $location->data['upgrade-cost-shipyard'] = $location->getShipyardUpgradeCost();
			// $location->data['upgrade-cost-lab'] = $location->getLabUpgradeCost();
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
		$this->TPL['user-update'] = $this->filteredUserData();
		$this->output->json_response($this->TPL);
	}

}
