<?php

class Fleet_m extends Model {

	public $data = array(
		'id' => NULL,
		'owner_id' => NULL,
		'location_id' => NULL,
		'size' => NULL,
		'destination_id' => NULL,
		'arrival_time' => NULL,
		'battle_id' => NULL
	);

	public function __construct($fleetID, $data = NULL){ 
		 parent::__construct(); 

		 if($data === NULL) {
		 	$data = $this->getFleetData($locationID);
		 }  
		 
		$this->data = $data;
	} 

	function getFleetData($locationID) {
		$sql = "SELECT * FROM fleets WHERE id = ?";
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

	public static function getSystemFleets($systemID) {
		$dbo = Database::getInstance();
		$dbh = $dbo->getPDOConnection();

		$sql = "SELECT f.*, l.position_x, l.position_y 
				FROM  `fleets` f
				JOIN  `locations` l ON f.location_id = l.id
				WHERE l.system_id = ?";
		$stmt = $dbh->prepare($sql);
    	$dbo->execute($stmt,array($systemID));

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


}