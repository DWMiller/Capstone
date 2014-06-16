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

	 public function getSystems($sectorID) {
			$sql = 'SELECT * FROM systems WHERE sector_id = ?';
			$stmt = $this->dbh->prepare($sql);
			$this->dbo->execute($stmt,array($sectorID));

			return $stmt->fetchAll(PDO::FETCH_ASSOC);
	 }

	 public function getLocations($systemID) {
			$sql = 'SELECT * FROM locations WHERE system_id = ?';
			$stmt = $this->dbh->prepare($sql);
			$this->dbo->execute($stmt,array($systemID));

			return $stmt->fetchAll(PDO::FETCH_ASSOC);
	 }
}
