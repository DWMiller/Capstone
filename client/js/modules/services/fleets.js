CORE.createModule('fleets', function(c, config) {
    'use strict';

    var p_properties = {
        id: 'fleets',
        listeners: {
            'fleet-update': fleetUpdate_Response,
            'fleet-move': moveFleet,
        }
    };

    /************************************ MODULE INITIALIZATION ************************************/

    /************************************ API REQUESTS ************************************/

    function moveFleet(data) {
        c.modules.animator.instance.state.action = false;

        if (data.splitSize && data.splitSize < 1) {
            return false;
        }

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
            c.notify({
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

        if (typeof data.split !== 'undefined') {
            moveRequest.split = data.split;
            moveRequest.splitSize = data.splitSize;
        }

        c.notify({
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

        c.notify({
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

        if (!found) {
            c.data.map.fleets.push(fleet);
            c.notify({
                type: 'inject-fleet',
                data: fleet
            });
        }
    }

    return {
        properties: p_properties,
    };

});
