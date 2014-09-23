<?php

class Users_m extends Model {
	private   $dbo;
	private   $dbh;
	 
	public function __construct(){ 
		parent::__construct();

		$this->dbo = Database::getInstance();
		$this->dbh = $this->dbo->getPDOConnection();
	} 
		
	public function createUser($email,$password) {
		$username = $this->generateRandomUserName();
		$salt = $this->getSalt();
		$password = hash('sha384',$salt.$password);  	

		$sql = 'INSERT INTO users (username,status,email,salt,password) values (?,?,?,?,?)';
		$stmt = $this->dbh->prepare($sql);

		$this->dbo->execute($stmt,array($username,1,$email,$salt,$password));

		return $stmt->rowCount() == 1;
	}


	public function getActiveUsersByField($val,$field = 'id') {		
		$sql = "SELECT * FROM users
		LEFT JOIN active_sessions ON user_id = id
		WHERE $field = ?";
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
		$sql = "INSERT INTO active_sessions (user_id,session,expires) values (?,?,?)";
		$stmt = $this->dbh->prepare($sql);
    
    	$session = $this->getSalt();
    	$expires = date('Y-m-d H:i:s',time()+2000);

    	$this->dbo->execute($stmt,array($userID,$session,$expires));

		return $session;
	}

	public function joinQueue(&$user) {
		$user['status'] = USER_QUEUED;

		$sql = "UPDATE users SET status = ? WHERE id = ?";
		$stmt = $this->dbh->prepare($sql);
    
    	$this->dbo->execute($stmt,array(USER_QUEUED,$user['id']));
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