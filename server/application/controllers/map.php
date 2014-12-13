<?php 	
/*=============================================================================
	This is an API endpoint which handles requests for map data
/*===========================================================================*/
class Map extends Core_Controller {
		
	private $map;	
	private $users;

	function __construct() {
		parent::__construct();

		$this->map = new Map_m();
		$this->users = new Users_m;	

		$this->requireAuthentication();

	}
	
	function index () {
		$this->done();
	}

	/**
	 * Request for all data in a given sector. For this application
	 * this amounts to a request for the entirety of game map data.
	 * @return void
	 */
	function sector () {	
		$args = func_get_args();
		$args = $args[0];

		$this->TPL['map-update']['systems'] = $this->map->getSystems($args['id']);

		//Get the fleets located on wormholes, as these will be visible on the sector view
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

	/**
	 * A request for all data on a given star system
	 * @return [type] [description]
	 */
	function system () {
		$args = func_get_args();
		$args = $args[0];

		$locations = $this->map->getLocations($args['id']);

		foreach ($locations as $key => $location) {
			$location = new Location_m($location['id'], $location);
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
		$this->TPL['user-update'] = output_filters::userData($this->User);
		$this->output->json_response($this->TPL);
	}

}
