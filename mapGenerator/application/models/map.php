<?php

class Map extends Model {
	private $dbo;
	private $dbh;

	private $map = array();
	private $mapNodes = array();
	 
	public function __construct(){ 
		parent::__construct();
		$this->dbo = Database::getInstance();
		$this->dbh = $this->dbo->getPDOConnection();
	 } 	

	 public function eraseMap() {
 		$sql = 'DELETE from locations; DELETE from systems; ';
 		$this->dbh->query($sql);
	 }

	public function createMap($scale,$seed) {
		$sector = new Sector(0,0,$seed); 
		$sector->populate($scale);
		$sector->save();
	}

}