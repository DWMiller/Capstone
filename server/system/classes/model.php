<?php
class Model {
    protected $dbo;
    protected $dbh;

	function __construct() {
		$this->dbo = Database::getInstance();
		$this->dbh = $this->dbo->getPDOConnection();				
	}

	protected static function getDatabaseHandler() {
		$dbo =  Database::getInstance();
		return $dbo->getPDOConnection();		
	}

}
