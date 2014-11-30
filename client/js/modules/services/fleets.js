CORE.createModule('fleets', function(c, config) {
    'use strict';

    var p_properties = {
        id: 'fleets',
    };

    var scope;

    var listeners = {
        'fleet-update': fleetUpdate_Response,
        'fleet-move': moveFleet,
    };

    var elements = {};

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id);

        // elements.back = scope.find('#map-back');

        bindEvents();
        // scope.show();
    }

    function p_destroy() {
        // scope.hide();
        unbindEvents();
        elements = {};
        scope = null;

    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }

    /************************************ API REQUESTS ************************************/

    function moveFleet(data) {
        c.modules.animator.instance.state.action = false;

        var fleet = data.fleet;
        var target = data.target;

        var destID = target.id;
        if (target.scale === 'system') {
            destID = target.wormhole_id;
        }

        var moveFleets = [fleet.id];

        if (c.modules.commands.instance.options.groupMove) {
            moveFleets = [];
            c.data.map.fleets.forEach(function(fleet) {
                if (fleet.owner_id === c.data.user.id) {
                    moveFleets.push(fleet.id);
                }
            });

            c.modules.commands.instance.toggleCommand('groupMove', false);
        }

        if (c.modules.commands.instance.options.fleetSplit && fleet.size > 1) {
            c.modules.animator.instance.state.action = true;
            scope.notify({
                type: 'show-widget-fleetSplitter',
                data: data
            });
            c.modules.commands.instance.toggleCommand('fleetSplit', false);
            return;
        }

        var moveRequest = {
            fleet: moveFleets,
            target: destID
        };

        if(typeof data.split !== 'undefined') {
            moveRequest.split = data.split;
            moveRequest.splitSize = data.splitSize;
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    fleets: {
                        move: moveRequest
                    }
                }
            }
        });
    }

    /************************************ API RESPONSES ************************************/

    function fleetUpdate_Response(data) {
        data.forEach(updateFleet);

        scope.notify({
            type: 'fleet-data-updated',
            data: true
        });

    }


    /************************************ FRAMEWORK LISTENERS ************************************/


    /************************************ UI Event Handlers ************************************/


    /************************************ GENERAL FUNCTIONS ************************************/

    function updateFleet(fleet) {
        var found = false;
        c.data.map.fleets.forEach(function(fleet2, index) {
            //find matching fleet in local data
            if (fleet.id === fleet2.id) {
                c.data.map.fleets[index] = fleet;
                found = true;
            }
        });

        if(!found) {
            c.data.map.fleets.push(fleet);
            scope.notify({
                type: 'inject-fleet',
                data: fleet
            });
        }
    }

    return {

        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
