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

	public function clearActivePlayers() {
		$sql = 'UPDATE users SET status = 1 WHERE status = 3';
		$this->dbh->query($sql);
	}

	public function activateQueuedPlayers() {
		$sql = 'UPDATE users SET status = 3 WHERE status = 2';
		$this->dbh->query($sql);
	}

	public function createNewGame($players = 12) {
		$sql = 'INSERT INTO game_settings (time_started,resource_pool,max_players) values (?,?,?);';
		$stmt = $this->dbh->prepare($sql);
		$data = array($expires = date('Y-m-d H:i:s',time()),0,$players);
		$this->dbo->execute($stmt,$data);		
	}

	/**
	 * Select starting location for each players. 
	 * Set locations to default state and grant ownership to player.
	 * @return [type] [description]
	 */
	public function placePlayers() {
		$users = new Users_m;
		$map = new Map_m;

		$players = $users->getUsersByField(USER_PLAYING,'status');

		$locations = $map->findStartingLocations(count($players));

		foreach ($players as $player) {
			$locationID = array_pop($locations);
			$map->setLocationOwner($locationID,$player['id']);
			$result = $map->setLocationAsHomeworld($locationID);
		}

	}


}
