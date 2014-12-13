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

	/**
	 * Adds an error to the generic error array for simplified error response to api requests
	 * @param [type] $strErrorTitle [description]
	 * @param [type] $strErrorMsg   [description]
	 */
	protected function addError($strErrorTitle, $strErrorMsg) {
		array_push($this->errors, array('title' => $strErrorTitle, 'msg'=> $strErrorMsg));
	} 

	/**
	 * Available to controllers to require that a user be authenticated to progress
	 * @return [type] [description]
	 */
	protected function requireAuthentication() {
		if(!$this->User) {
			$this->TPL['no-access'] = true;
			$this->output->json_response($this->TPL);
		}
	}

	/**
	 * Available to controllers to require that a user be an administrator to progress
	 * @return [type] [description]
	 */
	protected function requireAdmin() {
		if(!$this->User['is_admin']) {
			$this->TPL['no-access'] = true;
			$this->output->json_response($this->TPL);
		}
	}
}


