<?php

class Fleet_m extends Model {
	private   $dbo;
	private   $dbh;
	 
	public function __construct($locationID){ 
		 parent::__construct(); 
		 $this->dbo = Database::getInstance();
		 $this->dbh = $this->dbo->getPDOConnection();
	} 

}