<?php

class Userauth_m extends Model {

	private $username;
	private $password;

	private $user;

	private $users;

	public function __construct(){ 
		 parent::__construct();
		  $this->users = new Users_m;
	 } 
		
	public function login($email,$password)
	{
		//If user has active and valid session, return user data without trying needing to login again
		$user = $this->loggedIn();
		if ($this->user) {return $this->user;}

	    $this->email = $email;
	    $this->password = $password;
	               
	     //check if user account exists
		
		$this->user = $this->users->getUsersByField($this->email,'email')[0];

		if(!$this->user) {return false;}

		if(!$this->passwordCheck()) {return false;}		 	

		$this->user['session'] = $this->users->createSession($this->user['id']);

		//filter this for needed return data only
		return $this->user;
	}

	private function passwordCheck()
	{
		return($this->user['password'] == hash('sha384',$this->user['salt'].$this->password));
	}

	public function loggedIn() {

		$this->user = $this->validSessionExists();
		
		if (!$this->user) {return false;}

		// User has been idle too long
		//$this->timeoutCheck();

		//$this->hackerCheck();	

		// Check if admin has frozen account mid-session
		//$this->frozenCheck();

		return $this->user;
	}

	private function timeoutCheck()
	{
		// $now = time();
		// $expiry = 15;

		// if ($_SESSION['auth']['last_active'] < $now-$expiry)
		// {
		// 	$this->redirect($this->error_pages['timeout']);
		// }

		return false;
	}

	private function hackerCheck()
	{
		// if ($_SESSION['auth']['ipAddress'] != $_SERVER['REMOTE_ADDR']) {
		// 	$this->logout();
		// }

		// if ($_SESSION['auth']['HTTP_USER_AGENT'] != $_SERVER['HTTP_USER_AGENT']) {
		// 	//$this->logout();
		// }
		return false;
	}

	public function logout()
	{
		if(isset($_REQUEST['session'])) {
			$this->users->clearSession($_REQUEST['session']);
			$_SESSION = array();
			// session_destroy();			
		}
	}

	public function validSessionExists()
	{
		if(isset($_REQUEST['session'])) {
			return $this->users->getActiveUsersByField($_REQUEST['session'],'session')[0];
		} else {
			return false;
		}
	}

}
