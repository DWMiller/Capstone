<?php
class Output {
    
	function __construct() {
	}
	
	function json_response ($vars) {
		echo json_encode($vars);
	}
}
