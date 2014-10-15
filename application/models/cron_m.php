<?php

class Cron_m extends Model {
	private   $dbo;
	private   $dbh;
	 
	public function __construct(){ 
		 parent::__construct();
		 $this->dbo = Database::getInstance();
		 $this->dbh = $this->dbo->getPDOConnection();
	 } 

 	public function getMineData() {
		$sql = "SELECT owner_id,COUNT(mines) mine_count FROM locations WHERE owner_id IS NOT NULL GROUP BY owner_id";
		$stmt = $this->dbh->prepare($sql);
		$this->dbo->execute($stmt,array());
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
 	}

 	public function addResources($playerID, $amount) {
		$sql = "UPDATE users SET resources = resources + ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);
		$this->dbo->execute($stmt,array($amount,$playerID));	
 	}
}
