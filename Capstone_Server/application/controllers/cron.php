<?php 	

class Cron extends Controller {
	
	// private $Auth;
	private $Cron;
	private $mineRate = 2;

	function __construct() {
		parent::__construct();
		// $this->Auth = new userauth_m(); 
		$this->Cron = new Cron_m(); 

		// if(!$this->Auth->loggedIn()) {
		// 	exit;
		// }  
	}
	
	function index () {
		$this->output->json_response($this->TPL);
	}

	function executeTurn() {
		$this->Cron->addResources(); 
		//Bug - will not recognize lack of fleet while fleet is enroute
		$this->Cron->createMissingFleets();
		$this->Cron->addShips();		
	}
	
	function executeMaintainence() {
		$this->Cron->fleetArrivals();
		$this->Cron->fleetMergers();
		$this->Cron->combat();
		$this->Cron->fleetConquest();
		$this->Cron->removeEmptyFleets();
	}

}
