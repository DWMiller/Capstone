<?php
class View {
    
	function __construct() {
	}
	
	function render ($templateFile,$vars) {
		$TPL = $vars;

		require_once(ROOT . '/application/views/'. strtolower($templateFile) . '.php');
		//Note: A header and footer can be loaded here automatically each time the view is called. 
		
		echo '<pre>';
		echo print_r($TPL,true);
		echo '</pre>';

	}
}
