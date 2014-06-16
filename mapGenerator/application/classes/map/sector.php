<?php
class Sector extends MapNode {

	public $children = array();
	protected $childType = 'system';

	protected $size;

	public function __construct($x,$y,$seed){ 
		parent::__construct($x,$y,$seed);
		$this->category = 'sector';
		
	} 	

	// Creates region containing solar systems
	public function populate($scale) {
		$this->size = $this->seed;

		$this->scale = $scale;
		$this->distributeSeed();

		foreach ($this->children as $system) {
			$system->populate(1000);
		}	
	}

	public function save() {
		//save self to db

		//save children to db
		$this->saveChildren();
	}

	private function saveChildren() {
		foreach ($this->children as $system) {
			$system->save(1);
		}		
	}





}


