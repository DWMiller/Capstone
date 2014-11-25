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
	        $filteredData['knowledge'] = $this->User['knowledge'];
	        $filteredData['tech_weapons'] = $this->User['tech_weapons']+1;
	        $filteredData['tech_propulsion'] = $this->User['tech_propulsion']+1;
	        $filteredData['tech_armour'] = $this->User['tech_armour']+1;
	        $filteredData['tech_weapons_cost'] = 10 + ($this->User['tech_weapons']+1)*10;
	        $filteredData['tech_propulsion_cost'] = 10 + ($this->User['tech_propulsion']+1)*10;
	        $filteredData['tech_armour_cost'] = 10 + ($this->User['tech_armour']+1)*10;
        }

	 	return $filteredData;
	 }

}


