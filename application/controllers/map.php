<?php 	

class Map extends Controller {
		
	private $map;	
	private $Auth;
	private $users;
	private $user;

	function __construct() {
		parent::__construct();

		$this->map = new Map_m();

		$this->Auth = new userauth_m(); 
		$this->users = new Users_m;	

		$this->user = $this->Auth->loggedIn();
		if(!$this->user) {
			exit;
		}

	}
	
	function index () {
		$this->TPL['dispWelcomeMsg'] = true;
		$this->output->json_response($this->TPL);
	}

	function universe () {
		$args = func_get_args()[0];
		// $args['password']);

		$this->output->json_response($this->TPL);
	}

	function galaxy () {
		$args = func_get_args()[0];
		// $args['password']);

		$this->output->json_response($this->TPL);
	}

	function sector () {	
		$args = func_get_args()[0];
		// $args['password']);

		$this->TPL['map-update']['systems'] = $this->map->getSystems($args['id']);
		$this->TPL['user-update'] = $this->user;
		
		$this->output->json_response($this->TPL);
	}

	function system () {
		$args = func_get_args()[0];
		// $args['password']);

		$this->TPL['map-update']['locations'] = $this->map->getLocations($args['id']);
		$this->TPL['map-update']['fleets'] = Fleet_m::getSystemFleets($args['id']);

		$users = new Users_m;		
		$this->TPL['user-update'] = $this->user;

		$this->output->json_response($this->TPL);
	}			

}
