<?php
class Controller {
    
	public $output;
	protected $TPL = array();
	
	function __construct() {
		 $this->output = new Output;
	}
	
	
}
