<?php

class Map_m extends Core_Model {

	public function __construct(){ 
		 parent::__construct();
	 } 

	 public function getGalxies() {
	 	return false; //not implemented
	 }

	 public function getSectors() {
	 	return false; //not implemented
	 }

	 public function getSystems($val,$field = 'sector_id') {
			$sql = "SELECT s.*, SUM(f.size) as system_ships,  
			(SELECT id FROM locations WHERE system_id = s.id AND type = 'wormhole') as wormhole_id
			FROM `systems` s 			
			LEFT JOIN `locations` l ON l.system_id = s.id
			LEFT JOIN `fleets` f ON f.location_id = l.id
			WHERE $field = ?
			GROUP BY id";
			$stmt = $this->dbh->prepare($sql);
			$this->dbo->execute($stmt,array($val));

			return $stmt->fetchAll(PDO::FETCH_ASSOC);
	 }

	 public function getLocations($val,$field = 'system_id') {
			$sql = "SELECT * FROM locations WHERE $field = ?";
			$stmt = $this->dbh->prepare($sql);
			$this->dbo->execute($stmt,array($val));

			return $stmt->fetchAll(PDO::FETCH_ASSOC);
	 }

	 public function getUnclaimedStartLocations() {
			$sql = "SELECT * FROM locations WHERE owner_id IS NULL AND category = 'planet' ORDER BY resources DESC, size DESC";
			$stmt = $this->dbh->prepare($sql);
			$this->dbo->execute($stmt,array());
			return $stmt->fetchAll(PDO::FETCH_ASSOC);
	 }	 

/***************************************************************************/

	/**
	 * [findStartingLocations description]
	 * @param  [type] $quantity [description]
	 * @return int[] Array of location ids
	 */
 	public function findStartingLocations($quantity) {
 		$locations = $this->getUnclaimedStartLocations();
 		$selectedLocations = array();

 		for ($i=0; $i < $quantity; $i++) { 
 			// $randIndex = array_rand($locations);
 			// $selectedLocations[] = $locations[$randIndex]['id'];
 			$best = array_shift($locations);
 			$selectedLocations[] = $best['id'];
 		}

 		return $selectedLocations;
 	}

 	public function setLocationOwner($locationID,$userID) { 
			$sql = "UPDATE locations SET owner_id = ? WHERE id = ?";
			$stmt = $this->dbh->prepare($sql);
			return $this->dbo->execute($stmt,array($userID,$locationID));
 	}
	 
 	public function setLocationAsHomeworld($locationID) { 
			$sql = "UPDATE locations SET mines = ?, shipyards = ?, labs = ? WHERE id = ?";
			$stmt = $this->dbh->prepare($sql);
			return $this->dbo->execute($stmt,array(1,1,1,$locationID));
 	}

 	public static function getDistance($x1, $y1, $x2, $y2) {
 		$coordA = new Point($x1,$y1);
		$coordB = new Point($x2,$y2);

		return $coordA->distance($coordB);
 	}

}
