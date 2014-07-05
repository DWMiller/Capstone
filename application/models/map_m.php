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

	 public function getSystems($field = 'sector_id', $sectorID) {
			$sql = "SELECT * FROM systems WHERE $field = ?";
			$stmt = $this->dbh->prepare($sql);
			$this->dbo->execute($stmt,array($sectorID));

			return $stmt->fetchAll(PDO::FETCH_ASSOC);
	 }

	 public function getLocations($field = 'system_id',$systemID) {
			$sql = "SELECT * FROM locations WHERE $field = ?";
			$stmt = $this->dbh->prepare($sql);
			$this->dbo->execute($stmt,array($systemID));

			return $stmt->fetchAll(PDO::FETCH_ASSOC);
	 }

/***************************************************************************/

 	public function findStartingLocation() {

 	}

 	public function setLocationAsHomeworld($location,$userID) { 

 	}
	 
}
