// // Controls game processes
// // 
// game.modules.engine = function()
// {
// 	var properties = {
// 		name: 'engine'
// 	}

// 	var config = game.config[properties.name];


// 	function p_initialize()
// 	{
// 		console.log(properties.name+' initialized');
// 	}

// 	function FlyFleetFly()
// 	{
// 		var lastx;
// 		if(game.modules.data.fleets) {
// 			for (index in game.modules.data.fleets) {
// 				var object = game.modules.data.fleets[index];
// 				object.position_x = object.position_x +=1;	
// 				lastx = object.position_x;
// 			}
// 		}


// 		if(lastx < 100) {
// 			setTimeout(FlyFleetFly,config.SIM_INTERVAL);
// 		} else {
// 			setTimeout(FlyBack,config.SIM_INTERVAL);
// 		}
// 	}

// 	function FlyBack()
// 	{
// 		var lastx;
// 		if(game.modules.data.fleets) {
// 			for (index in game.modules.data.fleets) {
// 				var object = game.modules.data.fleets[index];
// 				object.position_x = object.position_x -=1;	
// 				lastx = object.position_x;
// 			}
// 		}

// 		if(lastx < 0) {
// 			setTimeout(FlyFleetFly,config.SIM_INTERVAL);
// 		} else {
// 			setTimeout(FlyBack,config.SIM_INTERVAL);
// 		}
// 	}

// 	function jiggle()
// 	{
// 			if(game.modules.data.map.sector) {
// 				for (index in game.modules.data.map.sector) {
// 					var object = game.modules.data.map.sector[index];
// 					object.position_y = +object.position_y + Math.random()*2-1;
// 					object.position_x = +object.position_x + Math.random()*2-1;	
// 				}
// 			}

// 			setTimeout(jiggle,config.SIM_INTERVAL);
// 	}

// 	return{
// 		initialize:p_initialize,
// 	}

// }()