<?php 	
/*=============================================================================
		This is an API endpoint that actually should be part of the API.
	These API requests are triggered by an admin user on the client and are 
	responsible for progressing the game.

		However, this a compromise due to the USBWebServer method of deployment.
	In practice, these commands should be run automatically on a timer
	by the server. In a live environment, this is relatively simple. In
	a portable one, it is not reasonably possible.

/*===========================================================================*/
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

	/**
	 * The primary game turns, responsible mainly for generating resources
	 * @return void
	 */
	function executeTurn() {
		$this->Cron->addResources(); 
		//Bug - will not recognize lack of fleet while fleet is enroute
		//	meaning ships will not generate until departing fleet arrives
		$this->Cron->createMissingFleets();
		$this->Cron->addShips();	
		$this->Cron->clearExpiredSessions();	
	}
	
	/**
	 * The combat turns, operating at a higher frequency than game turns and
	 * responsible for progressing/resolving fleet combat
	 * @return void
	 */	
	function executeCombatTurn() {
		$this->Cron->combat();
		$this->Cron->removeEmptyFleets();	
		$this->Cron->fleetConquest();
	}

	/**
	 * These are functions needing to be run at a very high frequency in
	 * order to simulate real time activity, such as fleet arrivals.
	 * @return void
	 */
	function executeMaintainence() {
		$this->Cron->fleetArrivals();
		$this->Cron->fleetMergers();
	}

}
