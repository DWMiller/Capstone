<?php
class Sector extends MapNode {

	public $children = array();
	protected $childType = 'system';

	public function __construct($coords,$seed){ 
		parent::__construct($coords,$seed);
		$this->category = 'sector';
		
	} 	

	// Creates region containing solar systems
	public function populate($scale) {
		$this->size = $this->seed;

		$this->scale = $scale;
		$this->distributeSeed(0);

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


