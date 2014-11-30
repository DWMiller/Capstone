<?php 	
class Cron extends Core_Controller {
	private $Cron;

	function __construct() {
		parent::__construct();
		$this->Cron = new Cron_m(); 
	}
	
	function index () {
		$this->output->json_response($this->TPL);
	}

	//*************TODO***********************/
	// Turns should be throttled based on timestamp of last turn, not on request frequency

	function executeTurn() {
		$this->Cron->addResources(); 
		//Bug - will not recognize lack of fleet while fleet is enroute
		$this->Cron->createMissingFleets();
		$this->Cron->addShips();	
		$this->Cron->clearExpiredSessions();	
	}
	
	function executeCombatTurn() {
		$this->Cron->combat();
		$this->Cron->removeEmptyFleets();	
		$this->Cron->fleetConquest();
	}

	function executeMaintainence() {
		$this->Cron->fleetArrivals();
		$this->Cron->fleetMergers();
	}

}
