<?php
class Core_Controller extends Controller {
	protected $Auth;
	protected $User;

	public function __construct(){ 
		 parent::__construct();
		 $this->Auth = new userauth_m(); 
		 $this->User = $this->Auth->loggedIn();
	 } 

	 //Takes user data and filters out anything not needed for api output
	 public function filteredUserData() {
	 	$filteredData = array(
	        'id' => $this->User['id'],
	        'status' => $this->User['status'],
	        // 'username' => $this->User['username']
        );

	 	if($this->User['is_admin']) {
	 		$filteredData['is_admin'] = $this->User['is_admin'];
	 	}

        if($this->User['status'] == USER_PLAYING) {
	        $filteredData['resources'] = $this->User['resources'];
	        $filteredData['tech_weapons'] = $this->User['tech_weapons'];
	        $filteredData['tech_propulsion'] = $this->User['tech_propulsion'];
	        $filteredData['tech_armour'] = $this->User['tech_armour'];
        }

	 	return $filteredData;
	 }

}


