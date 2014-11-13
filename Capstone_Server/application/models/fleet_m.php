<?php

class Fleet_m extends Model {

	public $data = array(
		'id' => NULL,
		'owner_id' => NULL,
		'location_id' => NULL,
		'size' => NULL,
		'destination_id' => NULL,
		'departure_time' => NULL,
		'arrival_time' => NULL,
		'battle_id' => NULL
	);

	public function __construct($fleetID, $data = NULL){ 
		 parent::__construct(); 

		 if($data === NULL) {
		 	$data = $this->getFleetData($fleetID);
		 }  
		 
		$this->data = $data;
	} 

	function move($location) {
		//shouldn't be instant, duh

		$distance = Map_m::getDistance($this->data['position_x'],$this->data['position_y'],$location->data['position_x'],$location->data['position_y']);
		$this->data['travelTime'] = $distance/FLEET_SPEED;

		// $date = new DateTime();
		// $date->modify('+'.$this->data['travelTime'].' seconds');
		// 
		$this->data['departure_time'] = time();
		$this->data['arrival_time'] = time()+$this->data['travelTime'];

		// $this->data['location_id'] = $location->data['id'];
		$this->data['destination_id'] = $location->data['id'];

		$sql = "UPDATE fleets SET destination_id = ?, departure_time = ?, arrival_time = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);    
    	return $stmt->execute(array(
    		$this->data['destination_id'],
    		$this->data['departure_time'],
    		$this->data['arrival_time'],
    		$this->data['id']));		
	}

	function getFleetData($fleetID) {
		$sql = "SELECT f.*, l.position_x, l.position_y, d.position_x destination_x, d.position_y destination_y
				FROM  `fleets` f
				JOIN  `locations` l ON f.location_id = l.id
				LEFT JOIN  `locations` d ON f.destination_id = d.id 
				WHERE f.id = ?";
		$stmt = $this->dbh->prepare($sql);
    	$this->dbo->execute($stmt,array($fleetID));

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

		$sql = "SELECT f.*, l.position_x, l.position_y, d.position_x destination_x, d.position_y destination_y, d.system_id destination_system
				FROM  `fleets` f
				JOIN  `locations` l ON f.location_id = l.id
				LEFT JOIN `locations` d ON f.destination_id = d.id
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

	public static function getWormholeFleets($sectorID) {
		$dbo = Database::getInstance();
		$dbh = $dbo->getPDOConnection();

		$sql = "SELECT f.*, s.position_x position_x, s.position_y position_y, s2.position_x destination_x, s2.position_y destination_y
				FROM  `fleets` f
				JOIN  `locations` l ON f.location_id = l.id
				LEFT JOIN  `locations` d ON f.destination_id = d.id
				JOIN  `systems` s ON l.system_id = s.id
				LEFT JOIN  `systems` s2 ON d.system_id = s2.id
				WHERE s.sector_id = ? AND l.type = 'wormhole'";
		$stmt = $dbh->prepare($sql);
    	$dbo->execute($stmt,array($sectorID));

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