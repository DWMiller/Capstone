<?php

class Admin_m extends Model {
	private   $dbo;
	private   $dbh;
	 
	public function __construct(){ 
		 parent::__construct();
	   
		 $this->dbo = Database::getInstance();
		 $this->dbh = $this->dbo->getPDOConnection();
	 } 


	 public function clearExpiredSessions() {
	 	$sql = file_get_contents('system/scripts/sessions.sql');
		$stmt = $this->dbh->prepare($sql);
		$this->dbo->execute($stmt,array());
	 }
}
