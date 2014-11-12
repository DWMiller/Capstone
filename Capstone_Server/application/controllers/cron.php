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

	function generateResources() {
		// $mines = $this->Cron->getMineData();

		// foreach ($mines as $row) {
		// 	$playerID = $row['owner_id'];
		// 	$mineCount = $row['mine_count'];

		// 	$income = $mineCount * $this->mineRate;

		// 	$this->Cron->addResources($playerID, $income);
		// }
			$this->Cron->addResources(); 
	}
	function generateShips() {
		//Bug - will not recognize lack of fleet while fleet is enroute
		$this->Cron->createMissingFleets();
		$this->Cron->addShips();
	}

	function updateFleets() {
		$this->Cron->fleetArrivals();
		$this->Cron->fleetConquest();
	}

	function executeTurn() {
		$this->generateResources();
		$this->generateShips();
		$this->updateFleets();		
	}
	
}
