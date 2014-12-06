<?php

class Fleet_m extends ORM {

	//DB properties
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

	public function __construct($fleetId, $data = NULL){ 
		parent::__construct($fleetId, $data);
	} 

	/**
	 * Overriding abstract method in ORM
	 * Default means of grabbing database data for an instance of this class
	 * @return mixed[] [description]
	 */
	protected function getData($id) {
    	return $this->getFleetData($id);
	}

	public function move($location, $propulsionTech) {
		if($this->data['location_system'] == $location->data['location_system']) {
			// Inner System movement
			$distance = Map_m::getDistance($this->data['position_x'],$this->data['position_y'],$location->data['position_x'],$location->data['position_y']);
		} else {
			// Inter-stellar movement
			$distance = SYSTEM_DISTANCE_MOD * Map_m::getDistance($this->data['location_system_x'],$this->data['location_system_y'],$location->data['location_system_x'],$location->data['location_system_y']);
		}
		
		$this->data['travelTime'] = $distance/(FLEET_SPEED + $propulsionTech * (FLEET_SPEED*.50));

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

	/**
	 * Move existing fleet, create new fleet in position with remaining ships
	 * @param  [type] $location  [description]
	 * @param  [type] $splitSize [description]
	 * @return [type]            [description]
	 */
	function splitMove($location, $splitSize, $propulsionTech) {
		//Move existing fleet immedietely, we'll reduce it enroute, which sounds stupid but should be fine
		$this->move($location,$propulsionTech);

		$remainingSize = $this->data['size'] - $splitSize;
		$this->data['size'] = $splitSize;

		$sql = "UPDATE fleets SET size = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);    
    	$stmt->execute(array($this->data['size'],$this->data['id']));


    	// Create new fleet at starting location with remaining ships
		
		$sql = "INSERT INTO fleets(location_id, owner_id, size) VALUES (?,?,?)";
		$stmt = $this->dbh->prepare($sql);  
		$stmt->execute(array($this->data['location_id'],$this->data['owner_id'], $remainingSize));

		return $this->dbh->lastInsertId();
	}


	function getFleetData($fleetID) {
		$sql = "SELECT f.*, l.position_x, l.position_y, l.owner_id location_owner, 
						l2.id location_system, l2.position_x location_system_x, l2.position_y location_system_y,
						d.position_x destination_x, d.position_y destination_y, 
						d2.id destination_system, d2.position_x destination_system_x, d2.position_y destination_system_y
				FROM  `fleets` f
				JOIN  `locations` l ON f.location_id = l.id
				JOIN  `systems` l2 ON l2.id = l.system_id
				LEFT JOIN  `locations` d ON f.destination_id = d.id 
				LEFT JOIN  `systems` d2 ON d2.id = d.system_id 
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

		$sql = "SELECT f.*, l.position_x, l.position_y, l.owner_id location_owner, d.position_x destination_x, d.position_y destination_y, d.system_id destination_system
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

		$sql = "SELECT f.*, l.position_x, l.position_y, l.owner_id location_owner, 
						l2.id location_system, l2.position_x location_system_x, l2.position_y location_system_y,
						d.position_x destination_x, d.position_y destination_y, 
						d2.id destination_system, d2.position_x destination_system_x, d2.position_y destination_system_y
				FROM  `fleets` f
				JOIN  `locations` l ON f.location_id = l.id
				JOIN  `systems` l2 ON l2.id = l.system_id
				LEFT JOIN  `locations` d ON f.destination_id = d.id
				LEFT JOIN  `systems` d2 ON d2.id = d.system_id 
				WHERE l2.sector_id = ? AND l.type = 'wormhole'";
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

	public static function getSectorFleets($sectorID) {
		$dbo = Database::getInstance();
		$dbh = $dbo->getPDOConnection();

		$sql = "SELECT SUM(f.size) size, f.owner_id, l2.id location_system
				FROM  `fleets` f
				JOIN  `locations` l ON f.location_id = l.id
				JOIN  `systems` l2 ON l2.id = l.system_id
				WHERE f.destination_id IS NULL
				AND l2.sector_id = ?
				GROUP BY location_system, f.owner_id";
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



