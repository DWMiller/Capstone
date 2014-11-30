<?php 
/**
 * A class providing consolidated access to input validation methods.
 */
 class Validator {

	/**
	 * [email description]
	 * @param  [type] $strEmail [description]
	 * @return bool           [description]
	 */
	public static function email($strEmail) {
		return filter_var($strEmail, FILTER_VALIDATE_EMAIL);
	}

	/**
	 * [password description]
	 * @param  [type] $strPassword [description]
	 * @return bool              [description]
	 */
	public static function password($strPassword) {
		return !empty($strPassword);
	}

	/**
	 * [username description]
	 * @param  [type] $strUsername [description]
	 * @return bool              [description]
	 */
	public static function username($strUsername) {
		return !empty($strUsername);
	}

	public static function locationName($strName) {
		return (strlen($strName) > 1);
	}
 } 


