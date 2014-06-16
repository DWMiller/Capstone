<?php 	

class Home extends Controller {
	
	 function __construct() {
		  parent::__construct();
	}
	
	function index () {
		$this->output->json_response($this->TPL);
	}
}
