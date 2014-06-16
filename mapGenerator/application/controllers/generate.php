<?php 	

class Generate extends Controller {
	
	private $map;

	public function __construct() {
		parent::__construct();
		$this->map = new Map;
	}
	
	public function index () {
		$this->view->render('generate_v',$this->TPL);
	}

	public function generate() {
		$this->map->eraseMap();
		$this->map->createMap($_POST['scale'],$_POST['seed']);
	}
}
