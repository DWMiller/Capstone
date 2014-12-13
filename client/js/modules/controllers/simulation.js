//Not used in current build
//
// CORE.createModule('simulation', function(c) {
//     'use strict';

//     var p_properties = {
//         name: 'simulation'
//     };

//     var scope, elements, config;
//     var listeners = {};

//     function p_initialize(sb) {
//         scope = sb.create(c, p_properties.id);
//         config = CORE.config[properties.name];
//         bindInputs();
//     }

//     function p_destroy() {
//         unbindEvents();
//         scope = null;
//         elements = {};
//     }

//     function bindEvents() {
//         scope.listen(listeners);
//     }

//     function unbindEvents() {
//         scope.ignore(Object.keys(listeners));
//     }


//     function FlyFleetFly() {
//         var lastx;
//         if (game.modules.data.fleets) {
//             for (var index in game.modules.data.fleets) {
//                 var object = game.modules.data.fleets[index];
//                 object.position_x = object.position_x += 1;
//                 lastx = object.position_x;
//             }
//         }


//         if (lastx < 100) {
//             setTimeout(FlyFleetFly, config.SIM_INTERVAL);
//         } else {
//             setTimeout(FlyBack, config.SIM_INTERVAL);
//         }
//     }

//     function FlyBack() {
//         var lastx;
//         if (game.modules.data.fleets) {
//             for (var index in game.modules.data.fleets) {
//                 var object = game.modules.data.fleets[index];
//                 object.position_x = object.position_x -= 1;
//                 lastx = object.position_x;
//             }
//         }

//         if (lastx < 0) {
//             setTimeout(FlyFleetFly, config.SIM_INTERVAL);
//         } else {
//             setTimeout(FlyBack, config.SIM_INTERVAL);
//         }
//     }

//     function jiggle() {
//         if (game.modules.data.map.sector) {
//             for (var index in game.modules.data.map.sector) {
//                 var object = game.modules.data.map.sector[index];
//                 object.position_y = +object.position_y + Math.random() * 2 - 1;
//                 object.position_x = +object.position_x + Math.random() * 2 - 1;
//             }
//         }

//         setTimeout(jiggle, config.SIM_INTERVAL);
//     }

//     return {
//         properties: p_properties,
//         initialize: p_initialize,
//         destroy: p_destroy
//     };

// });
