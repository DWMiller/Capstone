<?php

class Map_m extends Model {

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
			$sql = "SELECT * FROM systems WHERE $field = ?";
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

	 public function getUnclaimedLocations() {
			$sql = "SELECT * FROM locations WHERE owner_id IS NULL";
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
 		$locations = $this->getUnclaimedLocations();
 		$selectedLocations = array();

 		for ($i=0; $i < $quantity; $i++) { 
 			$randIndex = array_rand($locations);
 			$selectedLocations[] = $locations[$randIndex]['id'];
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