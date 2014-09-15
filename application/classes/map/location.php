<?php
class Location extends MapNode {

	public $children = array();

	public function __construct($coords,$seed){ 
		parent::__construct($coords,$seed);
		$this->category = 'location';
	} 	


	public function finalize() {
		$this->size = $this->seed;
		$this->type = $this->determineType('planets');	
	}

	public function save($systemID) {

		$sql = 'INSERT into locations (system_id,position_x,position_y,size,type,resources) values (?,?,?,?,?,?)';
		$stmt = $this->dbh->prepare($sql);

		try {
			$locationData = array(
				$systemID,
				$this->location->coords[0],
				$this->location->coords[1],
				$this->size,
				$this->type,
			);

			if(isset($GLOBALS['locations']['planets'][$this->type])) {
				$locationData[] = $GLOBALS['locations']['planets'][$this->type]['metal'];
			} else {
				$locationData[] = 0;
			}



		    $stmt->execute($locationData);
		} catch(PDOException $e) {
		    $this->dbo->showErrorPage("Unable to insert location",$e );	
		}  

	}



}
