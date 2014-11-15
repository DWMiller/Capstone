<?php
class Core_Controller extends Controller {
	protected $Auth;

	public function __construct(){ 
		 parent::__construct();

		 $this->Auth = new userauth_m(); 

	 } 
}