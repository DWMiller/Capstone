<?php 
/**
 * A class providing methods for the sanitization of output data
 */
 class output_filters {

	 /**
	  * Takes user data and filters out anything not needed for api output
	  * @param  [type] $user [description]
	  * @return [type]       [description]
	  */
	 public static function userData($user) {
	 	$filteredData = array(
	        'id' => $user['id'],
	        'status' => $user['status'],
	        // 'username' => $user['username']
        );

	 	if($user['is_admin']) {
	 		$filteredData['is_admin'] = $user['is_admin'];
	 	}

        if($user['status'] == USER_PLAYING) {
	        $filteredData['resources'] = $user['resources'];
	        $filteredData['knowledge'] = $user['knowledge'];
	        $filteredData['tech_weapons'] = $user['tech_weapons']+1;
	        $filteredData['tech_propulsion'] = $user['tech_propulsion']+1;
	        $filteredData['tech_armour'] = $user['tech_armour']+1;
	        $filteredData['tech_weapons_cost'] = 10 + ($user['tech_weapons']+1)*10;
	        $filteredData['tech_propulsion_cost'] = 10 + ($user['tech_propulsion']+1)*10;
	        $filteredData['tech_armour_cost'] = 10 + ($user['tech_armour']+1)*10;
        }

	 	return $filteredData;
	 }

 } 


