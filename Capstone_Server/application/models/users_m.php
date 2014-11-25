<?php

class Users_m extends Core_Model {

	public function __construct(){ 
		parent::__construct();
	} 
		
	public function createUser($email,$password) {
		$username = $this->generateRandomUserName();
		$salt = $this->getSalt();
		$password = hash('sha384',$salt.$password);  	

		$sql = 'INSERT INTO users (status,email,salt,password) values (?,?,?,?)';
		$stmt = $this->dbh->prepare($sql);
		$this->dbo->execute($stmt,array(1,$email,$salt,$password));

		$userID = $this->dbh->lastInsertId(); 

		//Maybe use a trigger for this?
		$sql = 'INSERT INTO user_settings (user_id,username) values (?,?)';
		$stmt = $this->dbh->prepare($sql);
		$this->dbo->execute($stmt,array($userID,$username));

		return $userID;
	}


	public function getActiveUsersByField($val,$field = 'id') {		
		$sql = "SELECT u.* FROM users u
		LEFT JOIN active_sessions a ON a.user_id = u.id
		WHERE a.".$field." = ?";

		$stmt = $this->dbh->prepare($sql);
    
    	$this->dbo->execute($stmt,array($val));

    	// Should only be one active session, session clearing logic is not implemented
		if ($stmt->rowCount() >= 1)
		{	
			$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
			return $result;
		} else {
			return false;
		}	
	}

	public function getUsersByField($val,$field = 'id') {		
		$sql = "SELECT * FROM users WHERE $field = ?";
		$stmt = $this->dbh->prepare($sql);
    
    	$this->dbo->execute($stmt,array($val));

		if ($stmt->rowCount() >= 1)
		{	
			$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
			return $result;
		} else {
			return false;
		}	
	}

	public function createSession($userID) {
		$ip = $this->getIP();

		$sql = "INSERT INTO active_sessions (user_id,ip,session,expires) values (?,?,?,?)";
		$stmt = $this->dbh->prepare($sql);
    
    	$session = $this->getSalt();
    	$expires = date('Y-m-d H:i:s',time()+SESSION_LIMIT);

    	$this->dbo->execute($stmt,array($userID,$ip,$session,$expires));

		return $session;
	}

	private function getIP() {
		//Test if it is a shared client
		if (!empty($_SERVER['HTTP_CLIENT_IP'])){
		  $ip=$_SERVER['HTTP_CLIENT_IP'];
		//Is it a proxy address
		}elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])){
		  $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
		}else{
		  $ip=$_SERVER['REMOTE_ADDR'];
		}
		//The value of $ip at this point would look something like: "192.0.34.166"
		return ip2long($ip); //The $ip would now look something like: 1073732954			
	}

	public function joinQueue(&$user) {
		$user['status'] = USER_QUEUED;

		$sql = "UPDATE users SET status = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);
    
    	$this->dbo->execute($stmt,array(USER_QUEUED,$user['id']));
	}

	public function removeResources($id,$amount) {
		$sql = "UPDATE users SET resources = resources - ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);
    	$stmt->execute(array($amount,$id));
	}

	public function removeKnowledge($id,$amount) {
		$sql = "UPDATE users SET knowledge = knowledge - ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);
    	$stmt->execute(array($amount,$id));
	}


	public function researchPropulsion($id) {
		$sql = "UPDATE users SET tech_propulsion = tech_propulsion + 1 WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);
		$stmt->execute(array($id));
	}

	public function researchWeapons($id) {
			$sql = "UPDATE users SET tech_weapons = tech_weapons + 1 WHERE id = ?";
			$stmt = $this->dbh->prepare($sql);
	    	$stmt->execute(array($id));
	}

	public function researchArmour($id) {
			$sql = "UPDATE users SET tech_armour = tech_armour + 1 WHERE id = ?";
			$stmt = $this->dbh->prepare($sql);
	    	$stmt->execute(array($id));
	}


	public function leaveQueue(&$user) {
		$user['status'] = USER_IDLE;

		$sql = "UPDATE users SET status = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);
    
    	$this->dbo->execute($stmt,array(USER_IDLE,$user['id']));
	}

	public function clearSession($session) {
		$sql = "DELETE FROM active_sessions WHERE session = ?";
		$stmt = $this->dbh->prepare($sql);
   
    	$this->dbo->execute($stmt,array($session));
	}

	public function clearAllSessions($userID) {
		$sql = "DELETE FROM active_sessions WHERE user_id = ?";
		$stmt = $this->dbh->prepare($sql);
    	$stmt->execute(array($userID));
	}

	private function getSalt() {
		$salt='';
		for ($i = 0; $i < 40; $i++) { 
		   $salt .= substr(
			 "./ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", 
			 mt_rand(0, 63), 
			 1); 
		}
		return $salt;
	}

	private function generateRandomUserName() {
		return $this->getSalt();
	}
}