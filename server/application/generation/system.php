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

		$star = $this->createStar();
		$this->children[] = $star;

		$wormhole = $this->createWormhole();

		$this->children[] = $wormhole;

		$this->distributeSeed($this->size);
		
		foreach ($this->children as $location) {
			if($location !== $star && $location !== $wormhole) {
				$location->finalize();
			}
		}	

	}

	private function createStar() {
		//Crete star as child for location logic
		$x = $this->scale/2;
		$y = $this->scale/2;

		$star = new $this->childType(new Point($x,$y),$this->size);	

		$this->name = $this->nameGenerator->generate();

		$star->size = $this->size;
		$star->type = $this->type;
		$star->category = 'star';
		$star->name = $this->name;

		return $star;		
	}

	private function createWormhole() {
		//Crete star as child for location logic
		$x = mt_rand(0,1000);
		$y = mt_rand(0,1000);

		$data = $GLOBALS['locations']['special']['wormhole'];

		$wormhole = new $this->childType(new Point($x,$y),$this->size);	

		$wormhole->size = $data['size'];
		$wormhole->type = 'wormhole';
		$wormhole->category = 'special';
		$wormhole->name = $this->name. " Wormhole";

		return $wormhole;		
	}

	public function save($sectorID) {
		//save self to db
		$sql = 'INSERT into systems (sector_id,position_x,position_y,name,size,type) values (?,?,?,?,?,?)';
		$stmt = $this->dbh->prepare($sql);

		try {
			if(!$this->name) {
				$this->name = $this->nameGenerator->generate();
			}

		    $stmt->execute(array(
		    	$sectorID,
		    	$this->location->coords[0],
		    	$this->location->coords[1],
		    	$this->name,
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
