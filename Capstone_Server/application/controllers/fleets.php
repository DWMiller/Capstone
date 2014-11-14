<?php 	

class Fleets extends Controller {
	private $Auth;
	private $Users;
	private $user;

	function __construct() {
		parent::__construct();
		$this->Auth = new userauth_m(); 
		$this->Users = new Users_m;	

		$this->user = $this->Auth->loggedIn();
		if(!$this->user) {
			exit;
		}
	}
	
	function move() {
		$args = func_get_args()[0];

		$fleet = new Fleet_m($args['fleet']);
		$targetLocation = new Location_m($args['target']);
		
		$fleet->move($targetLocation);

		$this->TPL['fleet-update'] = $fleet->getFleetData($fleet->data['id']);
		$this->output->json_response($this->TPL);
	}
}
