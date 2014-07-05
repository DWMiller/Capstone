<?php

class Game_m extends Model {
	private   $dbo;
	private   $dbh;
	 
	public function __construct(){ 
		 parent::__construct();
		 $this->dbo = Database::getInstance();
		 $this->dbh = $this->dbo->getPDOConnection();
	 } 

	 public function startNewGame() {
	 	//Set all player users to idle
	 	//Set all queued used to playing
	 	//Build new map scaled on number of playing users
	 	//place users on map
	 	//start game
	 	//send out alert that game has started
	 }



	 public function getCurrentGame() {
	 	$sql = 'SELECT * FROM game_settings';
		$stmt = $this->dbh->prepare($sql);
		$this->dbo->execute($stmt,array());	

		if ($stmt->rowCount() >= 1)
		{	
			$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
			return $result[0];
		} else {
			return false;
		}	
	 }

	 public function getNextGame() {
	 	return true;
	 }
}
