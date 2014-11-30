CORE.createModule('game', function(c, config) {
    'use strict';

    var p_properties = {
        id: 'game'
    };

    var scope;

    var listeners = {
        'game-update': updateGame,
        'map-update': updateMapData,
        'map-click': objectSelected,
        'map-data-outdated':requestUpdateNow
    };

    var updater;
    var history = [];

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-game');
        bindEvents();

        startUpdater();

        scope.notify({
            type: 'data-set',
            data: {
                map: {
                    scale: config.defaultData.scale,
                    // size: 100,
                    id: config.defaultData.id,
                    // sector: null,
                    // system: null,
                    // location: null
                }
            }
        });

        getMapData();
        scope.show();
    }

    function p_destroy() {
        scope.hide();
        unbindEvents();
        stopUpdater();
        scope = null;
    }

    function bindEvents() {
        scope.listen(listeners);
        // Great for performance, annoying for presentation
        // $(window).on('focus', windowFocusOn);
        // $(window).on('blur', windowFocusOut);        
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        $(window).off('focus', windowFocusOn);
        $(window).off('blur', windowFocusOut);
    }

    /********************************* UI Handlers ********************************/

    /**
     * A map object was selected, likely triggering map navigation.
     * @param  {[type]} object [description]
     * @return {[type]}        [description]
     */
    function objectSelected(object) {
        // System is lowest map layer, can not drill down further
        if (c.data.map.scale === 'system') {
            if (object.type === 'wormhole') {
                navigateBack();
            }
            return;
        }

        addHistory();

        c.data.map.scale = object.scale;
        c.data.map.id = object.id;
        // c.data.map.size = config.mapScaleFactor[object.scale];

        stopUpdater();
        getMapData();
        startUpdater();
    }

    /**
     * Map item passively selected, such as with a hover event. Shows details but does not trigger transitions.
     * @return {[type]} [description]
     */
    function objectFocused(object) {
        scope.notify({
            type: 'details-show',
            data: object
        });
    }

    function windowFocusOn() {
        startUpdater();
    }

    function windowFocusOut() {
        stopUpdater();
    }

    /************************************ POSTS ************************************/

    function getMapData() {
        var mapData = c.data.map;

        var data = {
            api: {
                map: {}
            }
        };

        data.api.map[mapData.scale] = {
            id: mapData.id
        };

        scope.notify({
            type: 'server-post',
            data: data
        });
    }

    /************************************ RESPONSES ************************************/

    function updateGame(data) {
        // scope.notify({
        //     type: 'data-set',
        //     data: {
        //         game: data.game
        //     }
        // });
    }

    function updateMapData(data) {

        if (data.fleets) {
            c.data.map.fleets = data.fleets;
        } else {
            c.data.map.fleets = false;
        }

        switch (c.data.map.scale) {
            case 'sector':
                c.data.map.sector = data.systems;
                break;
            case 'system':
                c.data.map.system = data.locations;
                break;
        }

        var systems = {};
        c.data.map.sector.forEach(function(system, index) {
            // map sectors to object properties based on id to simplify access later
            // TODO - This should be done once when data is first retrieved
            system.ownedShipTotal = 0;
            system.enemyShipTotal = 0;
            system.ownedLocationTotal = 0;
            system.enemyLocationTotal = 0;
            system.neutralLocationTotal = 0;
            systems[system.id] = system;

        });

        if (data.systemLocations) {
            //For each fleet, find matching system in sector data
            data.systemLocations.forEach(function(location) {
                if (location.owner_id === c.data.user.id) {
                    systems[location.location_system].ownedLocationTotal += location.owned_planets * 1;
                } else if (location.owner_id === null) {
                    systems[location.location_system].neutralLocationTotal += location.owned_planets * 1;
                } else {
                    systems[location.location_system].enemyLocationTotal += location.owned_planets * 1;
                }
            });
        }

        if (data.systemFleets) {
            //For each fleet, find matching system in sector data
            data.systemFleets.forEach(function(fleet) {
                if (fleet.owner_id === c.data.user.id) {
                    systems[fleet.location_system].ownedShipTotal += fleet.size * 1;
                } else {
                    systems[fleet.location_system].enemyShipTotal += fleet.size * 1;
                }
            });
        }

        scope.notify({
            type: 'data-updated',
            data: true
        });


    }

    /************************************ GENERAL FUNCTIONS ************************************/

    function startUpdater() {
        updater = setInterval(getMapData, config.UPDATE_INTERVAL);
    }

    function stopUpdater() {
        clearInterval(updater);
    }

    /**
     * Gets an immediate data update, reseting intervals
     * @return {[type]} [description]
     */
    function requestUpdateNow() {
        stopUpdater();
        getMapData();
        startUpdater();
    }

    function addHistory() {
        history[history.length] = {
            scale: c.data.map.scale,
            // size: c.data.map.size,
            id: c.data.map.id
        };
    }

    /**
     * Go up/back a layer in the map heirarchy
     * @return {[type]} [description]
     */
    function navigateBack() {
        c.data.map.fleets = null;
        c.data.map = history.pop();
        requestUpdateNow();
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
