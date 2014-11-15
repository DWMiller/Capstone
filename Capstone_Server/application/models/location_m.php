<?php

class Location_m extends Core_Model {

	//db reference vars
	public $data = [
		'id' => NULL,
		'owner_id' => NULL,
		'system_id' => NULL,
		'position_x' => NULL,
		'position_y' => NULL,
		'name' => NULL,
		'type' => NULL,
		'resources' => NULL,
		'size' => NULL,
		'mines' => NULL,
		'shipyards' => NULL,
		'labs' => NULL
	];

	private $structureCount;

	public function __construct($locationID, $data = NULL){ 
		 parent::__construct(); 

		 if($data === NULL) {
		 	$data = $this->getLocationData($locationID);
		 }  

		$this->data = $data;

		$this->structureCount = $this->data['shipyards']+$this->data['mines']+$this->data['labs'];
	} 

	function getLocationData($locationID) {
		$sql = "SELECT l.*, 
		l2.id as location_system, l2.position_x as location_system_x, l2.position_y as location_system_y
		FROM locations l
		JOIN systems l2 ON l2.id = l.system_id 
		WHERE l.id = ?";
		$stmt = $this->dbh->prepare($sql);
    	$this->dbo->execute($stmt,array($locationID));

    	// If more than one match, database is messed up
    	// If no matches, invalid request is being made
		if ($stmt->rowCount() == 1){	
			$result = $stmt->fetch(PDO::FETCH_ASSOC);			
			return $result;
		} else {
			return false;
		}	

		return $data;
	}

	public static function getPlayerLocations($userID) {
		$dbo = Database::getInstance();
		$dbh = $dbo->getPDOConnection();

		$sql = "SELECT * FROM locations WHERE owner_id = ?";
		$stmt = $dbh->prepare($sql);
    	$dbo->execute($stmt,array($userID));

    	// If more than one match, database is messed up
    	// If no matches, invalid request is being made
		if ($stmt->rowCount() > 0){	
			$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
			return $result;
		} else {
			return false;
		}	

		return $data;
	}

	function rename($name) {
		$this->data['name'] = $name;
		$sql = "UPDATE locations SET name = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);    
    	return $stmt->execute(array($this->data['name'],$this->data['id']));
	}


	function upgradeShipYard($increment = 1) {
		$this->data['shipyards']+=$increment;
		$sql = "UPDATE locations SET shipyards = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);    
    	return $this->dbo->execute($stmt,array($this->data['shipyards'],$this->data['id']));
	}

	function upgradeMine($increment = 1) {
		$this->data['mines']+=$increment;
		$sql = "UPDATE locations SET mines = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);    
    	return $this->dbo->execute($stmt,array($this->data['mines'],$this->data['id']));
	}

	function upgradeLab($increment = 1) {
		$this->data['labs']+=$increment;
		$sql = "UPDATE locations SET labs = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);    
    	return $this->dbo->execute($stmt,array($this->data['labs'],$this->data['id']));
	}

	function getMineUpgradeCost() {
		return round(pow($this->structureCount+1,2)*MINE_BASE/($this->data['size']/10));
	}

	function getShipyardUpgradeCost() {
		return round(pow($this->structureCount+1,2)*SHIPYARD_BASE/($this->data['size']/10));
	}

	function getLabUpgradeCost() {
		return round(pow($this->structureCount+1,2)*LAB_BASE/($this->data['size']/10));
	}	

}