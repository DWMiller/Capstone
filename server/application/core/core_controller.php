<?php
class Core_Controller extends Controller {
	protected $Auth;
	protected $User;
	protected $errors;

	public function __construct(){ 
		 parent::__construct();
		 $this->Auth = new userauth_m(); 
		 $this->User = $this->Auth->loggedIn();
		 $this->errors = array();
	 } 

	protected function addError($strErrorTitle, $strErrorMsg) {
		array_push($this->errors, array('title' => $strErrorTitle, 'msg'=> $strErrorMsg));
	} 

	protected function requireAuthentication() {
		if(!$this->User) {
			$this->TPL['no-access'] = true;
			$this->output->json_response($this->TPL);
		}
	}

	protected function requireAdmin() {
		if(!$this->User['is_admin']) {
			$this->TPL['no-access'] = true;
			$this->output->json_response($this->TPL);
		}
	}
}


