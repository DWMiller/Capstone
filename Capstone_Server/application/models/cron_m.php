<?php

class Cron_m extends Model {
	public function __construct(){ 
		 parent::__construct();
	 } 

 	// public function getMineData() {
		// $sql = "SELECT owner_id,COUNT(mines) mine_count FROM locations WHERE owner_id IS NOT NULL GROUP BY owner_id";
		// $stmt = $this->dbh->prepare($sql);
		// $this->dbo->execute($stmt,array());
		// return $stmt->fetchAll(PDO::FETCH_ASSOC);
 	// }

 	// public function addResources($playerID, $amount) {
		// $sql = "UPDATE users SET resources = resources + ? WHERE id = ?";
		// $stmt = $this->dbh->prepare($sql);
		// $this->dbo->execute($stmt,array($amount,$playerID));	
 	// }

 	public function addResources() {
		$sql = "UPDATE users u,
					(SELECT owner_id, sum(resources*mines)  as rsum
					FROM locations 
					WHERE owner_id IS NOT NULL
					GROUP BY owner_id) as s
				SET u.resources = u.resources + s.rsum
				WHERE u.id = s.owner_id AND u.status = 3";
		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());	
 	}

 	/**
 	 * Create a new fleet on every planet with shipyards that does not already have a fleet
 	 */
 	public function createMissingFleets() {
 		//TODO 
 		// No fleets may not be an adequate condition, as enemy fleets being present should not stop this process
 		// No owned fleets would be better, figure out SQL for it
 		$sql = "INSERT INTO fleets( location_id, owner_id ) 
				SELECT l.id, l.owner_id
				FROM  `locations` l
				LEFT JOIN  `fleets` f ON l.id = f.location_id
				WHERE l.shipyards >0
				AND f.id IS NULL";
		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());				
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
 		$sql="SELECT * ,SUM(size) size
			FROM fleets
			WHERE destination_id IS NULL
			GROUP BY location_id, owner_id
			HAVING COUNT(*) > 1";
		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());	

		if ($stmt->rowCount() > 0){	
			$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
			
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
 		$sql ="UPDATE `fleets` f
		JOIN `locations` l ON f.location_id = l.id AND f.owner_id = l.owner_id
		SET f.size = f.size + l.shipyards
		WHERE f.destination_id IS NULL";
		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());		
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
		    GROUP BY l2.id
		    ) as s ON l.id = s.id
		SET l.owner_id = s.owner_id
		WHERE s.c = 1";
 		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());		
	}

	public function combat() {
		// Select all locations with multiple fleets
		// Note: Fleet merging must precede this to ensure all fleets belong to different players
		$sql = "SELECT l.*
			FROM locations l
			JOIN fleets f 
			ON f.location_id = l.id
			WHERE f.destination_id IS NULL
			GROUP BY location_id
			HAVING COUNT(*) > 1";

 		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());

		if ($stmt->rowCount() > 0){	
			$locations = $stmt->fetchAll(PDO::FETCH_ASSOC);

			$sql = "SELECT * FROM fleets WHERE location_id = ?";
			$stmt = $this->dbh->prepare($sql);
			//Resolve combat at each location
			foreach ($locations as $key => $location) {
				$this->resolveLocationCombat($stmt,$location);
			}
		}	

	}

	private function resolveLocationCombat ($stmt,$location) {
		// SELECT * FROM fleets WHERE location = ?
		$stmt->execute(array($location['id']));

		if ($stmt->rowCount() > 0){	
			$fleets = $stmt->fetchAll(PDO::FETCH_ASSOC);

			$sql = "UPDATE fleets SET size = size - 4 WHERE location_id = ?";
			$stmt2 = $this->dbh->prepare($sql);

			// foreach ($fleets as $key => $fleet) {
				$stmt2->execute(array($location['id']));
			// }

			
		}
	}

	function removeEmptyFleets() {
		$sql = "DELETE FROM fleets WHERE size < 1";
		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array());
	}


}
