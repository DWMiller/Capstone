<?php

class Cron_m extends Core_Model {
	/*********************** QUERIES ************************************/

	// Grants users resources based on mine ownership, knowledge based on labs
	private $sql_addResources = "UPDATE users u,
					(SELECT owner_id, sum(resources*mines) as rsum, sum(labs) as lsum
					FROM locations 
					WHERE owner_id IS NOT NULL
					GROUP BY owner_id) as s
				SET u.resources = u.resources + s.rsum, u.knowledge = u.knowledge + s.lsum
				WHERE u.id = s.owner_id AND u.status = 3;";

	// Creates fleets where no fleet is present and location has a shipyard
	private $sql_createMissingFleets = "INSERT INTO fleets( location_id, owner_id ) 
				SELECT l.id, l.owner_id
				FROM  `locations` l
				LEFT JOIN  `fleets` f ON l.id = f.location_id
				WHERE l.shipyards > 0
				AND f.id IS NULL";

	// Gets representation of merged fleets at a location (all fleets owned by a user if ship counts were merged)
	private $sql_mergeFleets = "SELECT * ,SUM(size) size
			FROM fleets
			WHERE destination_id IS NULL
			GROUP BY location_id, owner_id
			HAVING COUNT(*) > 1";

	// Expand fleets based on shipyards/resources at fleet location
	private $sql_addShips = "UPDATE `fleets` f
		JOIN `locations` l ON f.location_id = l.id AND f.owner_id = l.owner_id
		SET f.size = f.size + (l.shipyards * l.resources/2) + l.shipyards
		WHERE f.destination_id IS NULL";

	// Get locations where combat is occuring 
	private $sql_combatLocations = "SELECT l.*
			FROM locations l
			JOIN fleets f 
			ON f.location_id = l.id
			WHERE f.destination_id IS NULL
			GROUP BY location_id
			HAVING COUNT(*) > 1";

	// Get fleets involved in combat at location
	private $sql_combatFleets = "SELECT f.*, u.tech_weapons, u.tech_armour FROM fleets f
				JOIN users u ON u.id = f.owner_id 
		 		WHERE f.location_id = ?
		 		ORDER BY f.size DESC";


	//Statements for above queries
	// Not strictly needed, but more efficient if a query is used more than once
	private $stmt_addResources;
	private $stmt_createMissingFleets;
	private $stmt_mergeFleets;
	private $stmt_addShips;
	private $stmt_combatLocations;
	private $stmt_combatFleets;


	public function __construct(){ 
		 parent::__construct();
		 $this->stmt_addResources = $this->dbh->prepare($this->sql_addResources);
		 $this->stmt_createMissingFleets = $this->dbh->prepare($this->sql_createMissingFleets);	
		 $this->stmt_mergeFleets = $this->dbh->prepare($this->sql_mergeFleets);
		 $this->stmt_addShips = $this->dbh->prepare($this->sql_addShips);
		 $this->stmt_combatLocations = $this->dbh->prepare($this->sql_combatLocations);
		 $this->stmt_combatFleets = $this->dbh->prepare($this->sql_combatFleets);
	} 

 	public function addResources() {
		$this->stmt_addResources->execute(array());	
 	}


	public function clearExpiredSessions() {
	 	$sql = "DELETE FROM active_sessions WHERE expires < NOW()";
		$this->dbh->query($sql);
	}

 	/**
 	 * Create a new fleet on every planet with shipyards that does not already have a fleet
 	 */
 	public function createMissingFleets() {
 		//TODO 
 		// No fleets may not be an adequate condition, as enemy fleets being present should not stop this process
 		// No owned fleets would be better, figure out SQL for it
		$this->stmt_createMissingFleets->execute(array());				
 	}


 	//Any location with more than one fleet owned by a single player will have those fleets merged
 	public function fleetMergers() {
 	// 	$sql = "INSERT INTO fleets (location_id,owner_id,size)
		// 	SELECT location_id,owner_id,SUM(size) size
		// 	FROM fleets
		// 	WHERE destination_id IS NULL
		// 	GROUP BY location_id, owner_id
		// 	HAVING COUNT(*) > 1";
		// $stmt = $this->dbh->prepare($sql);
		// $stmt->execute(array());

 		//Query representing new fleets that will be created

		$this->stmt_mergeFleets->execute(array());	

		if ($this->stmt_mergeFleets->rowCount() > 0){	
			$result = $this->stmt_mergeFleets->fetchAll(PDO::FETCH_ASSOC);
			
			//loop through fleets, delete all existing user fleets at location
			$sql = "DELETE FROM fleets WHERE owner_id = ? AND location_id = ? AND destination_id IS NULL";
			$stmt = $this->dbh->prepare($sql);
			foreach ($result as $key => $newFleet) {
				$stmt->execute(array($newFleet['owner_id'],$newFleet['location_id']));					
			}

			// Then, replace with newly created fleets
			// Super inefficient, at the very least bundle statements together prior to executing
			$sql = "INSERT INTO fleets(owner_id,location_id, size) VALUES (?,?,?)";
			$stmt = $this->dbh->prepare($sql);// 
			foreach ($result as $key => $newFleet) {
				$stmt->execute(array($newFleet['owner_id'],$newFleet['location_id'],$newFleet['size']));					
			}
			// echo '<pre>';
			// echo print_r($result,true);
			// echo '</pre>';
		}
 	}

 	/**
 	 * Add ships to fleets based on owned shipyards at location
 	 */
 	public function addShips() {
		$this->stmt_addShips->execute(array());		
 	}

 	public function fleetArrivals() {
 		$sql = "UPDATE `fleets` 
 		SET location_id = destination_id, destination_id = null, arrival_time = null, departure_time = null 
 		WHERE arrival_time < ".time();
 		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());
 	}

 	public function fleetConquest() {
 		$sql = "UPDATE locations as l
		    INNER JOIN (SELECT l2.id,f.owner_id,COUNT(*) c 
		    FROM fleets f
		    JOIN locations l2 ON f.location_id = l2.id
		    WHERE f.destination_id IS NULL
		    GROUP BY l2.id
		    ) as s ON l.id = s.id
		SET l.owner_id = s.owner_id
		WHERE s.c = 1 AND l.category = 'planet'";
 		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());		
	}

	public function combat() {
		// Select all locations with multiple fleets
		// Note: Fleet merging must precede this to ensure all fleets belong to different players

		$this->stmt_combatLocations->execute(array());

		if ($this->stmt_combatLocations->rowCount() > 0){	
			$locations = $this->stmt_combatLocations->fetchAll(PDO::FETCH_ASSOC);

			//Resolve combat at each location
			foreach ($locations as $key => $location) {
				$this->resolveLocationCombat($location);
			}
		}	

	}

	private function resolveLocationCombat ($location) {
		// SELECT * FROM fleets WHERE location = ?
		$this->stmt_combatFleets->execute(array($location['id']));

		if ($this->stmt_combatFleets->rowCount() > 0){	
			$fleets = $this->stmt_combatFleets->fetchAll(PDO::FETCH_ASSOC);

			// $sql = "UPDATE fleets SET size = size - 4 WHERE location_id = ?";
			// $stmt2 = $this->dbh->prepare($sql);

			// // foreach ($fleets as $key => $fleet) {
			// 	$stmt2->execute(array($location['id']));
			// // }
			// 
			
			
			//largest fleet attacks every other fleet, and is then removed from array
			//Then second largest fleet repeats, etc...
			//
			while(count($fleets) > 1) {
				$active = $fleets[0];

				// Get all fleets excluding first fleet (should be largest)
				$targets = array_slice($fleets, 1);

				foreach ($targets as $fleet) {
					$this->engagement($active,$fleet);
				}

				$fleets = $targets;
			}
		}
	}

	private function engagement($fleet1, $fleet2) {
		// echo '<pre>';
		// echo print_r($fleet1);
		// echo print_r($fleet2);
		// echo '</pre>';

		$fleet1AttackDie = new Dice(0,$fleet1['tech_weapons']);
		$fleet2AttackDie = new Dice(0,$fleet2['tech_weapons']);
		$fleet1DefDie = new Dice(0,$fleet1['tech_armour']);
		$fleet2DefDie = new Dice(0,$fleet2['tech_armour']);

		// Battle losses equal square root of average fleet size
		$avg = ($fleet1['size'] + $fleet2['size']) / 2;
		$losses = sqrt($avg);

		if($losses < 1) {
			$losses = 1;
		}
		
		//both sides lose sqrt of smaller fleet
		$fleet1['losses'] = $losses;
		$fleet2['losses'] = $losses;


		/***********Attack phase***********/

		$fleet1AttackRoll = $fleet1AttackDie->roll();
		$fleet2AttackRoll = $fleet2AttackDie->roll();

		// Whoever rolls higher kills extra 25%
		if($fleet1AttackRoll < $fleet2AttackRoll) {
			$fleet1['losses'] *= 1.25;
		} else {
			$fleet2['losses'] *= 1.25;
		}

		/*********** Save phase 1 ***********/
		// If player 2 makes a save roll, loses fewer ships
		
		$fleet1AttackRoll2 = $fleet1AttackDie->roll();
		$fleet2SaveRoll = $fleet2DefDie->roll();

		
		if($fleet1AttackRoll2 < $fleet2SaveRoll) {
			$fleet2['losses'] *= 0.75;
		}

		/*********** Save phase 2 ***********/
		// If player 1 makes a save roll, loses fewer ships

		$fleet2AttackRoll2 = $fleet2AttackDie->roll();
		$fleet1SaveRoll = $fleet1DefDie->roll();

		if($fleet2AttackRoll2 < $fleet1SaveRoll) {
			$fleet1['losses'] *= 0.75;
		}

	 	$sql = "UPDATE `fleets` SET size = size - ? WHERE id = ?;
 		UPDATE `fleets` SET size = size - ? WHERE id = ?;
 		INSERT INTO `battle_logs` (
 			location_id,
 			player1_id,
 			player2_id,
 			player1_roll,
 			player2_roll,
 			player1_bonus_roll,
 			player2_bonus_roll,
 			player1_bonus_roll2,
 			player2_bonus_roll2,
 			player1_losses,
 			player2_losses)
 		VALUES (?,?,?,?,?,?,?,?,?,?,?);";
 		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array(
			$fleet1['losses'],
			$fleet1['id'],
			$fleet2['losses'],
			$fleet2['id'],
			$fleet1['location_id'],
			$fleet1['owner_id'],
			$fleet2['owner_id'],
			$fleet1AttackRoll,
			$fleet2AttackRoll,
			$fleet1AttackRoll2,
			$fleet2SaveRoll,
			$fleet1SaveRoll,
			$fleet2AttackRoll2,		
			$fleet1['losses'],
			$fleet2['losses']));	
	}


	function removeEmptyFleets() {
		$sql = "DELETE FROM fleets WHERE size < 1";
		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());
	}


}

class Dice {

	private $min;
	private $max;

	public function __construct($min = 0, $max = 1) { 
		$this->min = $min;
		$this->max = $max; 
	} 

	public function roll() {
		return rand($this->min,$this->max);
	}

}