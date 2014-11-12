<?php
class MapNode {

	protected $dbo;
	protected $dbh;

	protected $category;


	protected $location;
	protected $scale; //length & width of node
	protected $seed; 
	
	protected $size;
	
	protected $nameGenerator;
	protected $name;

	public function __construct($coords,$seed){ 
		$this->dbo = Database::getInstance();
		$this->dbh = $this->dbo->getPDOConnection();

		$this->nameGenerator = new NameGenerator();
		
		$this->location = $coords;
		$this->seed = $seed;
	} 	


	/**
	 * [distributeSeed description]
	 * @param  [type] $range Minimum distance from center point to place objects
	 * @return [type]        [description]
	 */
	public function distributeSeed($range) {

		// Run until all seed is allocatted
		while($this->seed > 0) {

			// place new node or attempt to grow existing nodes
			// less likely to place new node as node count increases
			if(!mt_rand(0,count($this->children))) {
				$amount = $this->createChildNode($range);
			} else {
				$amount = $this->growAllChildNodes();
			}
			
			$this->seed -= $amount;
		}
	}

	/**
	 * [createChildNode description]
	 * @param  [type] $range [description]
	 * @return [type]        [description]
	 */
	public function createChildNode($range) {
			// note: check positioning prior to placement
			// bigger objects must be further from other objects 
			// 
		while(true) {
			//pick random coordinate
			$x = mt_rand(0,$this->scale);
			$y = mt_rand(0,$this->scale);

			$center = new Point($this->scale/2,$this->scale/2);
			$coords = new Point($x,$y);

			// Must be outside bounds of star
			// $distance = $center->distance($coords);

			$valid = true;
			foreach ($this->children as $key => $child) {
				$d = $coords->distance($child->location);

				if($d < 125 + $child->size) {
					$valid = false;
					break;
				}
			}	

			//make sure not colliding with other children
			if($valid) {
				$this->children[] = new $this->childType($coords,4);	
				return 4;
			}				
		}
	}


	public function growAllChildNodes() {
		$amount = 0;

		//check distance to center point
		//check distance to siblings
		foreach ($this->children as $node) {
			$amount += $node->grow();
		}

		return $amount;
	}


	protected function determineType($group) {
		$list = array();

		// Get list of stars that match this size
		foreach ($GLOBALS['locations'][$group] as $type => $details) {
			if($this->size >= $details['minSize'] && $this->size <= $details['maxSize']) {
				$list[] = $type;
			}
		}

		$rand = array_rand($list);
		
		return $list[$rand];

	}


	// public function pull(&$nodeMap) {
	// 	$nodes = $this->getNearbyNodes($nodeMap);

	// 	$hasPulled = false;
	// 	// loop through surrounding nodes
	// 	foreach ($nodes as $coords) {

	// 		$x = $coords[0];
	// 		$y = $coords[1];

	// 		$node = $nodeMap[$x][$y];


	// 		if($node->size) {
	// 			if($this->size > $node->size) {
	// 				$this->size++;
	// 				$node->size--;
	// 				$hasPulled = true;
	// 			} else if($this->size == $node->size) {

	// 				$this->size+=$node->size;
	// 				$node->size = 0;
	// 				$hasPulled = true;		
	// 			}
				
	// 		}
	// 	}
		

	// 	$this->calcRange();
	// 	return $hasPulled;

	// }

	public function grow() {
		$originalSize = $this->seed;
		//bigger it gets, less likely to grow
		if(mt_rand(0,$this->seed) === 0) {
			$this->seed *= 1.5;
		} 

		//return size of growth
		return $this->seed - $originalSize;

	}

	// private function getNearbyNodes(&$nodeMap) {
	// 	$nodes = array();

	// 	$innerBound = $this->range * (sqrt(2.0) / 2.0);

	// 	$scale = count($nodeMap);

	// 	for ($x=0; $x < $scale; $x++) { 
	// 		for ($y=0; $y < $scale; $y++) { 

	// 			//Don't add self
	// 			if($this == $nodeMap[$x][$y]) {continue;}

	// 			$xDist = abs($this->x - $x);
	// 			$yDist = abs($this->y - $y);

	// 			// outer bound box
	// 			if($xDist > $this->range || $yDist > $this->range ) {continue;}

	// 			if($xDist > $innerBound || $yDist > $innerBound ) {continue;}

	// 			$nodes[] = array($x,$y);

	// 		}
	// 	}

	// 	return $nodes;		
	// }
}