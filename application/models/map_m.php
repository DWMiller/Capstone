<?php

class Map_m extends Model {
	private   $dbo;
	private   $dbh;
	 
	public function __construct(){ 
		 parent::__construct();
	   
		 $this->dbo = Database::getInstance();
		 $this->dbh = $this->dbo->getPDOConnection();
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

	 public function eraseMap() {
 		$sql = 'DELETE from locations; DELETE from systems; ';
 		$this->dbh->query($sql);
	 }

	public function createMap($scale,$seed) {
		$sector = new Sector(new Point(0,0),$seed); 
		$sector->populate($scale);
		$sector->save();
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

}
