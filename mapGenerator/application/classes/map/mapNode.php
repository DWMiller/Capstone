<?php
class MapNode {

	protected $dbo;
	protected $dbh;

	protected $category;

	protected $location;
	protected $scale; //length & width of node
	protected $seed; 
	
	public function __construct($x,$y,$seed){ 
		$this->dbo = Database::getInstance();
		$this->dbh = $this->dbo->getPDOConnection();

		$this->location = new Point($x,$y);
		$this->seed = $seed;
		
		//$this->calcRange();
	} 	


	public function distributeSeed() {
		// Run until all seed is allocatted

		while($this->seed > 0) {

			// place new node or attempt to grow existing nodes
			// less likely to place new node as node count increases
			if(!mt_rand(0,count($this->children))) {
				$amount = $this->createChildNode();
			} else {
				$amount = $this->growAllChildNodes();
			}
			
			$this->seed -= $amount;
		}
	}

	public function createChildNode() {
			// note: check positioning prior to placement
			// bigger objects must be further from other objects 

		//pick random coordinate
		$x = mt_rand(0,$this->scale);
		$y = mt_rand(0,$this->scale);

		$this->children[] = new $this->childType($x,$y,4);	

		return 4;
	}


	public function growAllChildNodes() {
		$amount = 0;

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



	public function calcRange() {
		$this->range = sqrt($this->seed);
		if($this->range < 2) {$this->range = 2;}
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

	private function getNearbyNodes(&$nodeMap) {
		$nodes = array();

		$innerBound = $this->range * (sqrt(2.0) / 2.0);

		$scale = count($nodeMap);

		for ($x=0; $x < $scale; $x++) { 
			for ($y=0; $y < $scale; $y++) { 

				//Don't add self
				if($this == $nodeMap[$x][$y]) {continue;}

				$xDist = abs($this->x - $x);
				$yDist = abs($this->y - $y);

				// outer bound box
				if($xDist > $this->range || $yDist > $this->range ) {continue;}

				if($xDist > $innerBound || $yDist > $innerBound ) {continue;}

				$nodes[] = array($x,$y);

			}
		}

		return $nodes;		
	}
}