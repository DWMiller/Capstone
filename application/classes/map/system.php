<?php
class System extends MapNode {

	public $type;
	public $children = array();
	
	protected $childType = 'location';

	public function __construct($coords,$seed){ 
		parent::__construct($coords,$seed);
		$this->category = 'system';

	} 	

	public function populate($scale) {
		$this->size = $this->seed;
		$this->type = $this->determineType('stars');	

		$this->scale = $scale;
		$this->distributeSeed($this->size);

		foreach ($this->children as $location) {
			$location->finalize();
		}	

		//Crete star as child for location logic

		$x = $this->scale/2;
		$y = $this->scale/2;

		$star = new $this->childType(new Point($x,$y),$this->size);	
		$star->size = $this->size;
		$star->type = $this->type;

		$this->children[] = $star;
		
	}

	public function save($sectorID) {
		//save self to db
		$sql = 'INSERT into systems (sector_id,position_x,position_y,name,size,type) values (?,?,?,?,?,?)';
		$stmt = $this->dbh->prepare($sql);

		try {
		    $stmt->execute(array(
		    	$sectorID,
		    	$this->location->coords[0],
		    	$this->location->coords[1],
		    	$this->nameGenerator->generate(),
		    	$this->size,$this->type));
		} catch(PDOException $e) {
		    $this->dbo->showErrorPage("Unable to insert system",$e );	
		}  

		$this->saveChildren();
	}

	public function saveChildren() {
		$systemID = $this->dbh->lastInsertId();

		foreach ($this->children as $location) {
			$location->save($systemID);
		}		
	}



}
