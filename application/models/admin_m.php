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

	public function deleteCurrentGame() {
		$sql = 'TRUNCATE TABLE game_settings;';
		$this->dbh->query($sql);
	}

	public function createNewGame() {
		$sql = 'INSERT INTO game_settings (time_started,resource_pool,max_players) values (?,?,?);';
		$stmt = $this->dbh->prepare($sql);
		$data = array($expires = date('Y-m-d H:i:s',time()),0,$_REQUEST['player_count']);
		$this->dbo->execute($stmt,$data);		
	}


}
