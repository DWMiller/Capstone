CORE.createModule('map', function(c, config) {
    'use strict';

    var p_properties = {
        id: 'map',
    };

    var scope;

    var listeners = {
        'map-update': updateMapData,
        'location-update': updateLocation,
        'fleet-update': updateFleet,

    };

    var elements = {
        stage: null,
        layers: {
            map: new Kinetic.Layer(),
            overlay: new Kinetic.Layer(),
            fleets: new Kinetic.Layer()
        }
    };

    var history = [];

    var state = false,
        imageResources = {};

    var updater, animator;

    var baseFontSize = 16;
    var baseLineSpacing = 4;

    var defaultText = {
        fontSize: baseFontSize,
        fontFamily: 'Georgia',
        fill: '#FFF'
    };
    var defaultIcon = {
        width: 20,
        height: 20
    };

    var w, h;

    var userSystems = {};

    var activeFleet = null,
        fleetTarget = null;
    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-game');

        elements.mapWrapper = $("#game-map");

        elements.user = $('#module-user');

        w = elements.mapWrapper.width();
        h = elements.mapWrapper.height() - elements.user.height();

        elements.back = scope.find('#map-back');
        elements.stage = new Kinetic.Stage({
            container: 'game-map',
            width: w,
            height: h
        });

        bindEvents();

        loadGameResources();

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

        state = true;

        startUpdater();

        addHistory();

        calcUserSystems();

        animator = requestAnimationFrame(animate);

        scope.show();
    }

    function p_destroy() {
        cancelAnimationFrame(animator);
        scope.hide();
        state = false;
        unbindEvents();
        scope = null;
        elements = {};
        stopUpdater();
    }

    function bindEvents() {
        scope.listen(listeners);

        scope.addEvent(elements.back, 'click', backButtonClick);

        elements.layers.map.on('click touchstart', layerClickHandler);
        // scope.addEvent(elements.layers.fleets, 'click', layerClickHandler);
        // 
        elements.layers.map.on('mouseover touchstart', showDetails);

        // Need pointer cursor on image hover, 
        // Add hover class to page while image is hovered
        elements.layers.map.on('mouseover', imageMouseon);
        elements.layers.map.on('mouseout', imageMouseout);

        elements.layers.fleets.on('dragstart', fleetDragStart);
        elements.layers.fleets.on('dragend', fleetDragEnd);
        elements.layers.fleets.on('dragmove', fleetDragging);
    }

    function unbindEvents() {
        elements.layers.map.off('click touchstart', layerClickHandler);
        // scope.removeEvent(elements.layers.fleets, 'click', layerClickHandler);

        scope.ignore(Object.keys(listeners));

        scope.removeEvent(elements.back, 'click', backButtonClick);
        elements.layers.map.off('mouseover touchstart', showDetails);

        elements.layers.map.off('mouseover', imageMouseon);
        elements.layers.map.off('mouseout', imageMouseout);

        elements.layers.fleets.off('dragstart', fleetDragStart);
        elements.layers.fleets.off('dragend', fleetDragEnd);

    }

    /************************************ UI Handlers ************************************/
    function backButtonClick() {
        navigateBack();
    }

    function imageMouseon() {
        c.dom.addClass(scope.self(), 'hover');
    }

    function imageMouseout() {
        c.dom.removeClass(scope.self(), 'hover');
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

    function moveFleet(fleet, target) {
        var destID = target.id;
        if(target.scale === 'system') {
            destID = target.wormhole_id;
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    fleets: {
                        move: {
                            fleet: fleet.id,
                            target: destID
                        }
                    }
                }
            }
        });
    }

    /************************************ RESPONSES ************************************/
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

        populate();
    }

    /**
     * [updateLocation description]
     * @param  {[type]} data Object representing data for a single location
     * @return {[type]}      [description]
     */
    function updateLocation(data) {
        var matched;
        c.data.map.system.forEach(function(location, index, system) {
            if (location.id === data.id) {
                system[index] = data;
            }
        });

        populate();
    }

    function updateFleet(data) {
        startUpdater();
    }

    /************************************ UI Event Handlers ************************************/

    function layerClickHandler(event) {
        // System is lowest map layer, can not drill down further
        if (c.data.map.scale === 'system') {
            return;
        }

        addHistory();

        var object = event.target.data;

        c.data.map.scale = object.scale;
        c.data.map.id = object.id;
        c.data.map.size = config.mapScaleFactor[object.scale];

        state = false;
        getMapData();
        state = true;

    }

    function fleetDragStart(event) {
        stopUpdater();
        activeFleet = event.target.data;
    }

    function fleetDragging(event) {
        var kImg = event.target;
        processFleetIntersections(kImg);
    }

    function fleetDragEnd(event) {
        if (fleetTarget) {
            moveFleet(activeFleet, fleetTarget.data);
        } else {
            //Start updated again if no movement being triggered
            //If movement triggered, updater should be started once fleet update is returned
            startUpdater();
        }

        scope.notify({
            type: 'details-hide',
            data: true
        });

    }

    /************************************ GENERAL FUNCTIONS ************************************/
    function processFleetIntersections(kImg) {
        var fleet = kImg.data;

        var collisionFound = false,
            changed = false;

        // only need to check collisions against 
        // all objects once collision with last collided object has stopped
        // otherwise just check if still colliding with last object
        if (fleetTarget) {
            var stillColliding = doObjectsCollide(kImg, fleetTarget);
            if (stillColliding) {
                return;
            }
        }

        elements.layers.map.getChildren().each(function(img) {
            var location = img.data;
            if (location.id === fleet.location_id) {
                return;
            }

            if (doObjectsCollide(img, kImg)) {
                if (!fleetTarget || fleetTarget.data !== location) {
                    changed = true;
                }

                fleetTarget = img;
                collisionFound = true;
                return;
            }
        });

        if (!collisionFound) {
            fleetTarget = null;
            scope.notify({
                type: 'details-hide',
                data: true
            });
        } else {
            fleetTarget.data.fleetMove = true;
            if (changed) {
                scope.notify({
                    type: 'details-show',
                    data: fleetTarget.data
                });
            }

        }
    }

    function doObjectsCollide(a, b) { // a and b are your objects
        var x1, y1, w1, h1, x2, y2, w2, h2;
        x1 = a.getX();
        y1 = a.getY();
        w1 = a.getWidth();
        h1 = a.getHeight();
        x2 = b.getX();
        y2 = b.getY();
        w2 = b.getWidth();
        h2 = b.getHeight();

        w2 += x2;
        w1 += x1;
        if (x2 > w1 || x1 > w2) return false;
        h2 += y2;
        h1 += y1;
        if (y2 > h1 || y1 > h2) return false;
        return true;
    }

    //Loop through user locations to determine which systems user has a presence in
    function calcUserSystems() {
        userSystems = {};
        if (c.data['user-locations']) {
            c.data['user-locations'].forEach(function(location) {
                userSystems[location.system_id] = true;
            });
        }
    }

    function scaleCoordinates(x, y) {
        return {
            x: x / 1000 * (w * 0.85) + w * 0.07,
            y: y / 1000 * (h * 0.85) + h * 0.07
        };
    }

    /**
     * Go up/back a layer in the map heirarchy
     * @return {[type]} [description]
     */
    function navigateBack() {
        c.data.map = history.pop();
        state = false;
        getMapData();
        state = true;
    }

    function showDetails(event) {
        scope.notify({
            type: 'details-show',
            data: event.target.data
        });
    }

    function addHistory() {
        history[history.length] = {
            scale: c.data.map.scale,
            size: c.data.map.size,
            id: c.data.map.id
        };
    }

    /**
     * Loads all game resources
     * Decides identifier key for loaded images
     * @return {[type]} [description]
     */
    function loadGameResources() {
        loadImage('system-terran', 'system/terran.png');
        loadImage('system-desert', 'system/desert.png');
        loadImage('system-gasGiant', 'system/gasGiant.png');
        loadImage('system-ice', 'system/ice.png');
        loadImage('system-molten', 'system/molten.png');
        loadImage('system-volcanic', 'system/volcanic.png');
        loadImage('system-asteroid', 'system/asteroid.png');
        loadImage('system-blueStar', 'system/blueStar.png');
        loadImage('system-redStar', 'system/redStar.png');
        loadImage('system-yellowStar', 'system/yellowStar.png');
        loadImage('system-whiteStar', 'system/whiteStar.png');
        loadImage('system-wormhole', 'system/wormhole.png');
        loadImage('sector-blueStar', 'sector/blueStar.png');
        loadImage('sector-redStar', 'sector/redStar.png');
        loadImage('sector-yellowStar', 'sector/yellowStar.png');
        loadImage('sector-whiteStar', 'sector/whiteStar.png');
        loadImage('fleet', 'fleet.png');
        loadImage('beaker', 'beaker.png');
        loadImage('anchor', 'anchor.png');
        loadImage('mine', 'mine.png');
    }

    /**
     * Fetches and pre-loads image into properties of imageResources for later usage
     * @param  {[type]} key  [description]
     * @param  {[type]} path [description]
     * @return {[type]}      [description]
     */
    function loadImage(key, fileName) {
        imageResources[key] = new Image();
        imageResources[key].src = config.imagePath + fileName;
    }

    function setStageSize() {
        var correctHeight = $(scope.self()).height() - elements.user.height();

        if (h != correctHeight || w != elements.mapWrapper.width()) {
            w = elements.mapWrapper.width();
            h = correctHeight;
            elements.stage.setWidth(w);
            elements.stage.setHeight(h);
            console.log('resizing');
        }
    }

    function populate() {

        //Should call on resize rather than within animation function
        setStageSize();

        elements.layers.map.destroyChildren();
        elements.layers.overlay.destroyChildren();
        elements.layers.fleets.destroyChildren();

        imageMouseout();

        if (c.data.map.sector && c.data.map.scale === 'sector') {
            c.data.map.sector.forEach(addSystemToMap);
        }

        if (c.data.map.system && c.data.map.scale === 'system') {
            c.data.map.system.forEach(addLocationToMap);
        }

        if (c.data.map.fleets) {
            c.data.map.fleets.forEach(addFleetToMap);
        }

        elements.stage.add(elements.layers.map);
        elements.stage.add(elements.layers.fleets);
        elements.stage.add(elements.layers.overlay);
    }

    function simulateFleetMovement() {
        var time = Math.round((new Date()).getTime());

        elements.layers.fleets.getChildren().each(function(img) {
            var fleet = img.data;

            if (fleet.destination_id) {

                var elapsedTime = time - fleet.departure_time * 1000;
                var tripTime = fleet.arrival_time * 1000 - fleet.departure_time * 1000;

                if (elapsedTime > tripTime) {
                    // stopUpdater();
                    // startUpdater();
                    return;
                }

                var percentTravelled = elapsedTime / tripTime;

                var x = (fleet.position_x * 1) + ((fleet.destination_x - fleet.position_x) * 1) * percentTravelled;
                var y = (fleet.position_y * 1) + ((fleet.destination_y - fleet.position_y) * 1) * percentTravelled;

                var coords = scaleCoordinates(x, y);

                img.setX(coords.x);
                img.setY(coords.y);

                fleet.overlay.forEach(function(e) {
                    e.remove();
                });

                fleet.overlay = addFleetOverlay(fleet, img.attrs);


            }
        });
    }

    function addFleetToMap(fleet) {

        fleet.scale = 'fleet';

        var x = fleet.position_x;
        var y = fleet.position_y;

        if (fleet.destination_id) {

            if(c.data.map.scale === 'system' && fleet.destination_system !== c.data.map.id) {
                // Don't show fleet in system if enroute to different system
                return;
            }

            var time = Math.round((new Date()).getTime() / 1000);

            var elapsedTime = time - fleet.departure_time;
            var tripTime = fleet.arrival_time - fleet.departure_time;

            if (elapsedTime < tripTime) {
                var percentTravelled = elapsedTime / tripTime;
                x = (fleet.position_x * 1) + ((fleet.destination_x - fleet.position_x) * 1) * percentTravelled;
                y = (fleet.position_y * 1) + ((fleet.destination_y - fleet.position_y) * 1) * percentTravelled;
            } else {
                x = fleet.destination_x;
                y = fleet.destination_y;
            }
        }

        var coords = scaleCoordinates(x, y);

        var owned = (fleet.owner_id === c.data.user.id);

        var drawWidth = 50;
        var drawHeight = 40;

        var kImage = new Kinetic.Image({
            x: coords.x, //center the image
            y: coords.y - 5, //center the image
            image: imageResources[config.imageMapping.fleet],
            draggable: owned,
            width: drawWidth,
            height: drawHeight
        });

        kImage.data = fleet;

        elements.layers.fleets.add(kImage);

        kImage.cache();
        kImage.filters([Kinetic.Filters.RGB]);

        if (owned) {
            kImage.green(255);
        } else {
            kImage.red(255);
        }

        fleet.overlay = addFleetOverlay(fleet, kImage.attrs);
    }

    function addSystemToMap(system) {
        system.scale = 'system';
        system.src = 'sector-' + system.type;

        var coords = scaleCoordinates(system.position_x, system.position_y);

        var drawWidth = Math.sqrt(system.size) * config.drawScaleFactor[c.data.map.scale];
        var drawHeight = Math.sqrt(system.size) * config.drawScaleFactor[c.data.map.scale];

        var kImage = new Kinetic.Image({
            x: coords.x - drawWidth / 2, //center the image
            y: coords.y - drawHeight / 2, //center the image
            image: imageResources[config.imageMapping[system.src]],
            width: drawWidth,
            height: drawHeight
        });

        kImage.data = system;

        elements.layers.map.add(kImage);
        addSystemOverlay(system, kImage.attrs);
    }

    function addLocationToMap(location) {
        location.scale = 'location';
        location.src = 'system-' + location.type;

        var coords = scaleCoordinates(location.position_x, location.position_y);

        var drawWidth = Math.sqrt(location.size) * config.drawScaleFactor[c.data.map.scale];
        var drawHeight = Math.sqrt(location.size) * config.drawScaleFactor[c.data.map.scale];

        var kImage = new Kinetic.Image({
            x: coords.x - drawWidth / 2, //center the image
            y: coords.y - drawHeight / 2, //center the image
            image: imageResources[config.imageMapping[location.src]],
            width: drawWidth,
            height: drawHeight
        });

        kImage.data = location;

        elements.layers.map.add(kImage);
        addLocationOverlay(location, kImage.attrs);
    }

    /**
     * [addSystemOverlay description]
     * @param {[type]} system The object data
     * @param {[type]} kImage The data of the drawn image representing the object
     */
    function addSystemOverlay(system, kImage) {
        // var coords = $.extend(true, defaultText, {
        //     x: kImage.x,
        //     y: kImage.y + kImage.height,
        //     text: '( ' + system.position_x + ', ' + system.position_y + ' )',
        //     fill: (userSystems[system.id]) ? '#0FC90A' : '#FFF'
        // });

        var name = $.extend({}, defaultText, {
            x: kImage.x,
            y: kImage.y + kImage.height + baseLineSpacing,
            text: system.name,
            fill: (userSystems[system.id]) ? '#0FC90A' : '#FFF'
        });

        elements.layers.overlay.add(new Kinetic.Text(name));
    }

    function addLocationOverlay(location, kImage) {
        var color;

        if (!location.owner_id) {
            color = '#FFF';
        } else if (location.owner_id === c.data.user.id) {
            color = '#00FF00';
        } else {
            color = '#FF0000';
        }

        var name = $.extend({}, defaultText, {
            x: kImage.x,
            y: kImage.y + kImage.height + baseLineSpacing,
            text: location.name,
            fill: color
        });

        elements.layers.overlay.add(new Kinetic.Text(name));

        if(location.type === 'wormhole' || (location.position_x == 500 && location.position_y == 500)) {
            return;
        }


        var iconY = kImage.y + (kImage.height / 3) - (baseFontSize + baseLineSpacing) * 2;

        var iconWidth = 20;
        var iconHeight = 20;
        var iconX = kImage.x - 30;

        var iconSpacing = 5;

        var mineIcon = $.extend({}, defaultIcon, {
            x: iconX,
            y: iconY,
            image: imageResources[config.imageMapping.mine]
        });

        iconX += (iconWidth + iconSpacing);
        var mineCount = $.extend({}, defaultText, {
            x: iconX,
            y: iconY,
            text: location.mines,
            fill: color
        });
        iconX += (iconWidth + iconSpacing);

        var shipyardIcon = $.extend({}, defaultIcon, {
            x: iconX,
            y: iconY,
            image: imageResources[config.imageMapping.anchor]
        });

        iconX += (iconWidth + iconSpacing);
        var shipyardCount = $.extend({}, defaultText, {
            x: iconX,
            y: iconY,
            text: location.shipyards,
            fill: color
        });
        iconX += (iconWidth + iconSpacing);

        var labIcon = $.extend({}, defaultIcon, {
            x: iconX,
            y: iconY,
            image: imageResources[config.imageMapping.beaker]
        });

        iconX += (iconWidth + iconSpacing);
        var labCount = $.extend({}, defaultText, {
            x: iconX,
            y: iconY,
            text: location.labs,
            fill: color
        });

        // 
        // var coords = $.extend({}, defaultText, {
        //     x: kImage.x + kImage.width + 5,
        //     y: iconY + baseFontSize + baseLineSpacing,
        //     text: '( ' + location.position_x + ', ' + location.position_y + ' )',
        //     fill: (c.data.user.id === location.owner_id) ? '#0FC90A' : '#FFF'
        // });

        // elements.layers.overlay.add(new Kinetic.Text(coords));


        elements.layers.overlay.add(new Kinetic.Image(mineIcon));
        elements.layers.overlay.add(new Kinetic.Text(mineCount));

        elements.layers.overlay.add(new Kinetic.Image(shipyardIcon));
        elements.layers.overlay.add(new Kinetic.Text(shipyardCount));

        elements.layers.overlay.add(new Kinetic.Image(labIcon));
        elements.layers.overlay.add(new Kinetic.Text(labCount));
    }

    function addFleetOverlay(fleet, kImage) {
        var overlay = [];
        var owned = (fleet.owner_id === c.data.user.id);

        var size = $.extend({}, defaultText, {
            x: kImage.x + kImage.width + 3,
            y: kImage.y,
            text: fleet.size,
            fill: owned ? '#0FC90A' : '#FF0000'
        });

        if (fleet.destination_id) {
            var destination = scaleCoordinates(fleet.destination_x, fleet.destination_y);
            var x = kImage.x + kImage.width / 2;
            var y = kImage.y + kImage.height / 2;

            var line = new Kinetic.Line({
                points: [x, y, destination.x, destination.y],
                stroke: owned ? '#0FC90A' : '#FF0000',
                lineJoin: 'round',
                strokeWidth: 2,
                // tension: 1,
                dash: [10, 5]
            });
            elements.layers.overlay.add(line);
            overlay.push(line);
        }

        size = new Kinetic.Text(size);
        overlay.push(size);

        elements.layers.overlay.add(size);

        return overlay;
    }

    function animate() {
        simulateFleetMovement();

        elements.stage.drawScene();

        console.log('animate');

        if (state) {
            animator = requestAnimationFrame(animate);
        }
    }

    function startUpdater() {
        getMapData();
        // populate();
        updater = setInterval(getMapData, config.UPDATE_INTERVAL);
    }

    function stopUpdater() {
        clearInterval(updater);
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
