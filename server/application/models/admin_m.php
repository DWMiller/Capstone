<?php

class Admin_m extends Core_Model {
	public function __construct(){ 
		 parent::__construct(); 
	} 

	public function deleteCurrentGame() {
		$sql = 'TRUNCATE TABLE game_details;';
		$this->dbh->query($sql);
	}

	public function clearActivePlayers() {
		$sql = 'UPDATE users SET status = 1 WHERE status = 3';
		$this->dbh->query($sql);
	}

	public function queueAllPlayers() {
		$sql = 'UPDATE users SET status = 2';
		$this->dbh->query($sql);
	}

	public function activateQueuedPlayers() {
		$sql = 'UPDATE users SET status = 3, resources = 50, knowledge = 0, tech_armour = 0, tech_weapons = 0, tech_propulsion = 0 WHERE status = 2';
		$result = $this->dbh->query($sql);
		return $result->rowCount();
	}

	public function createNewGame($players) {
		$sql = 'INSERT INTO game_details (time_started,players) values (?,?);';
		$stmt = $this->dbh->prepare($sql);
		$data = array($expires = date('Y-m-d H:i:s',time()),$players);
		$this->dbo->execute($stmt,$data);		
	}

	public function eraseBattleLogs() {
		$sql = 'TRUNCATE battle_logs';
 		$this->dbh->query($sql);
	}

	public function eraseMap() {
 		$sql = 'SET FOREIGN_KEY_CHECKS = 0; TRUNCATE locations; TRUNCATE systems; SET FOREIGN_KEY_CHECKS = 1;';
 		$this->dbh->query($sql);
	}

	public function eraseFleets() {
 		$sql = 'TRUNCATE fleets;';
 		$this->dbh->query($sql);
	}

	public function createMap($size,$players) {
		$seed = 100*log($players);
		$sector = new Sector(new Point(0,0),$seed); 
		$sector->populate($size);
		$sector->save();
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
