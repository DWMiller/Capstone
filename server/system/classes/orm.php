<?php
abstract class ORM extends Model {
	function __construct($id, $data) {
		parent::__construct();		

		if($data === NULL) {
			$data = $this->getData($id);
		}  
		 
		$this->data = $data;
	}

	public function __get($name) {
	    // echo "Getting '$name'\n";
	    if (array_key_exists($name, $this->data)) {
	        return $this->data[$name];
	    }
	}

	abstract protected function getData($key);
}
