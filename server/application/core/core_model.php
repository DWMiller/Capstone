<?php
/**
 * Does nothing at all.
 * Was initially going to host ORM functions, but those were moved to the framework.
 * May be deleted in future builds unless a reasonable usage is found.
 */
class Core_Model extends Model {
	public function __construct(){ 
		 parent::__construct();
	 } 
}