<?php 	

class Map extends Controller {
		
	private $map;	

	function __construct() {
		  parent::__construct();

		  $this->map = new Map_m();
	}
	
	function index () {
		$this->TPL['dispWelcomeMsg'] = true;
		$this->output->json_response($this->TPL);
	}

	function universe () {
		$this->output->json_response($this->TPL);
	}

	function galaxy () {
		$this->output->json_response($this->TPL);
	}

	function sector () {		
		$this->TPL['systems'] = $this->map->getSystems($_REQUEST['sector']);
		$this->output->json_response($this->TPL);
	}

	function system () {
		$systemID = $_REQUEST['system'];
		$this->TPL['locations'] = $this->map->getLocations($systemID);
		$this->output->json_response($this->TPL);
	}			

}
