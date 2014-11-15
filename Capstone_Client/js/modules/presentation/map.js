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
        imageResources = {
            sprites: {}
        };

    var updater, animator;

    var baseFontSize = 16;
    var baseLineSpacing = 4;

    var defaultText;

    var defaultIcon = {
        width: 20,
        height: 20
    };

    var w, h;

    var userSystems = {};

    var activeFleet = null,
        fleetTarget = null;

    var lastDragCheck, dragCheckThreshold = 300; // limits drag handling logic to occur every x amount of milliseconds

    var time = new Date().getTime();
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

        defaultText = { // Default to be used when creating kinetic text objects
                fontSize: baseFontSize,
                fontFamily: 'Georgia',
                fill: config.colours.neutralWhite.hex
        };

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

        startUpdater();
        getMapData();

        addHistory();

        calcUserSystems();

        animator = requestAnimationFrame(animate);

        scope.show();
    }

    function p_destroy() {
        cancelAnimationFrame(animator);
        scope.hide();
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

        // Great for performance, annoying for presentation
        // $(window).on('focus', windowFocusOn);
        // $(window).on('blur', windowFocusOut);

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

        $(window).off('focus', windowFocusOn);
        $(window).off('blur', windowFocusOut);        

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

    function moveFleet(fleet, target) {
        var destID = target.id;
        if (target.scale === 'system') {
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
        if (!state) {
            return;
        }

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
        c.data.map.fleets.forEach(function(fleet, index) {
            if (data.id === fleet.id) {
                c.data.map.fleets[index] = data;
            }
        });

        if(state) {
            populateFleets(); 
        } else {
            startUpdater();
        }   
    }

    /************************************ UI Event Handlers ************************************/

    function layerClickHandler(event) {
        var object = event.target.data;

        // System is lowest map layer, can not drill down further
        if (c.data.map.scale === 'system') {

            if(object.type==='wormhole') {
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

    function fleetDragStart(event) {
        lastDragCheck = time;

        stopUpdater();
        activeFleet = event.target.data;
    }

    function fleetDragging(event) {
        if(lastDragCheck > (time - dragCheckThreshold)) {
            return;
        }
        
        lastDragCheck = time;

        var kImg = event.target;
        processFleetIntersections(kImg);
    }

    function fleetDragEnd(event) {
        if (fleetTarget) {
            moveFleet(activeFleet, fleetTarget.data);
        } else {
            //Start updated again if no movement being triggered
            //If movement triggered, updater should be started once fleet update is returned
            // startUpdater();
        }

        startUpdater();

        scope.notify({
            type: 'details-hide',
            data: true
        });

    }

    /************************************ GENERAL FUNCTIONS ************************************/
    function processFleetIntersections(kFleet) {

        var fleet = kFleet.data;

        var collisionFound = false,
            changed = false;

        // only need to check collisions against 
        // all objects once collision with last collided object has stopped
        // otherwise just check if still colliding with last object
        if (fleetTarget) {
            var stillColliding = doObjectsCollide(kFleet, fleetTarget);
            if (stillColliding) {
                return;
            }
        }

        elements.layers.map.getChildren().each(function(kLocation) {
            var location = kLocation.data;

            if (location.id === fleet.location_id) {
                return;
            }

            if (doObjectsCollide(kLocation, kFleet)) {

                if (!fleetTarget || fleetTarget.data !== location) {
                    changed = true;
                }

                fleetTarget = kLocation;
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
        c.data.map.fleets = null;
        stopUpdater();

        c.data.map = history.pop();

        startUpdater();
        getMapData();
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
            // size: c.data.map.size,
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
        loadImage('explosion', 'system/explosion.jpg');
        loadImage('beaker', 'beaker.png');
        loadImage('anchor', 'anchor.png');
        loadImage('mine', 'mine.png');

        loadSprites();
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


    function loadSprites() {
        var w = 84,
            h = 84;
        imageResources.sprites.wormhole = {
            // x: 500,
            // y: 500,
            image: imageResources[config.imageMapping['system-wormhole']],
            animation: 'idle',
            // width:  20 * config.drawScaleFactor.system,
            // height: 20 * config.drawScaleFactor.system,
            animations: {
                idle: [
                    // x, y, width, height (4 frames)
                    0, 0, w, h,
                    w, 0, w, h,
                    w * 2, 0, w, h,
                    w * 3, 0, w, h,

                    0, w, w, h,
                    w, w, w, h,
                    w * 2, w, w, h,
                    w * 3, w, w, h,

                    0, w * 2, w, h,
                    w, w * 2, w, h,
                    w * 2, w * 2, w, h,
                    w * 3, w * 2, w, h,

                    0, w * 3, w, h,
                    w, w * 3, w, h,
                    w * 2, w * 3, w, h
                ]
            },
            frameRate: 15,
            frameIndex: 0
        };
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

    function populateFleets() {
        //Clearing fleet layer won't clear fleet overlays
        clearFleetOverlays();
        elements.layers.fleets.destroyChildren();

        if (c.data.map.fleets) {
            c.data.map.fleets.forEach(addFleetToMap);
        }

        elements.stage.add(elements.layers.fleets);
    }

    function clearFleetOverlays() {
        elements.layers.fleets.getChildren().each(function(img) {
            img.data.overlay.forEach(function(e) {            
                e.remove();
                e = null;
            });
            img.data.overlay = null;
        });
    }

    function simulateFleetMovement() {
        // clearFleetOverlays();

        elements.layers.fleets.getChildren().each(function(img) {
            var fleet = img.data;

            if(fleet.arrived) {
                // This fleet was moved and has arrived in a previous simulation
                // Nothing to update until fresh map data replaces it
                return;
            }

            var x1, y1, x2, y2;

            if (c.data.map.scale === 'system') {
                x1 = fleet.position_x;
                y1 = fleet.position_y;
                x2 = fleet.destination_x;
                y2 = fleet.destination_y;
            } else if (c.data.map.scale === 'sector') {
                x1 = fleet.location_system_x;
                y1 = fleet.location_system_y;
                x2 = fleet.destination_system_x;
                y2 = fleet.destination_system_y;
            }

            if (fleet.destination_id) {

                //Clear overlay for this fleet, will be recreated - Note, should be moved instead of replaced
                fleet.overlay.forEach(function(e) {            
                    e.remove();
                    e = null;
                });
                fleet.overlay = null;

                var elapsedTime = time - fleet.departure_time * 1000;
                var tripTime = fleet.arrival_time * 1000 - fleet.departure_time * 1000;

                if (elapsedTime > tripTime) {
                    x1 = x2;
                    y1 = y2;
                    fleet.arrived = true;
                    // Should only fire once per fleet
                    // getMapData();
                    // stopUpdater();
                    // startUpdater();
                    // return;
                } else {
                    var percentTravelled = elapsedTime / tripTime;
                    x1 = (x1 * 1) + ((x2 - x1) * 1) * percentTravelled;
                    y1 = (y1 * 1) + ((y2 - y1) * 1) * percentTravelled;                    
                }

                var coords = scaleCoordinates(x1, y1);

                img.setX(coords.x);
                img.setY(coords.y);

                fleet.overlay = addFleetOverlay(fleet, img.attrs);
            }
        });

        // Add fresh overlays to all fleets
        // elements.layers.fleets.getChildren().each(function(img) {
        //     var fleet = img.data;
        //     fleet.overlay = addFleetOverlay(fleet, img.attrs);
        // });

        
    }

    function addFleetToMap(fleet) {

        fleet.scale = 'fleet';
        var x1, y1, x2, y2;

        if (c.data.map.scale === 'system') {
            x1 = fleet.position_x;
            y1 = fleet.position_y;
            x2 = fleet.destination_x;
            y2 = fleet.destination_y;
        } else if (c.data.map.scale === 'sector') {
            x1 = fleet.location_system_x;
            y1 = fleet.location_system_y;
            x2 = fleet.destination_system_x;
            y2 = fleet.destination_system_y;
        }

        if (fleet.destination_id) {

            if (c.data.map.scale === 'system' && fleet.destination_system !== c.data.map.id) {
                // Don't show fleet in system if enroute to different system
                return;
            }

            var elapsedTime = time - fleet.departure_time;
            var tripTime = fleet.arrival_time - fleet.departure_time;

            if (elapsedTime < tripTime) {
                var percentTravelled = elapsedTime / tripTime;
                x1 = (x1 * 1) + ((x2 - x1) * 1) * percentTravelled;
                y1 = (y1 * 1) + ((y2 - y1) * 1) * percentTravelled;
            } else {
                x1 = x2;
                y1 = y2;
            }

        }

        var coords = scaleCoordinates(x1, y1);

        // For fleets at location, draw on different sides of planet if owner or not
        if (!fleet.destination_id) {
            if (fleet.location_owner == fleet.owner_id) {
                coords.x += 10;
                coords.y -= 15;
            } else {
                coords.x -= 50;
                coords.y -= 15;
            }
        }

        var owned = (fleet.owner_id === c.data.user.id);

        var drawWidth = 50;
        var drawHeight = 40;

        var kImage = new Kinetic.Image({
            x: coords.x, //center the image
            y: coords.y, //center the image
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
            kImage.red(config.colours.ownedGreen.r);
            kImage.green(config.colours.ownedGreen.g);
            kImage.blue(config.colours.ownedGreen.b);
        } else {
            kImage.red(config.colours.enemyRed.r);
            kImage.green(config.colours.enemyRed.g);
            kImage.blue(config.colours.enemyRed.b);
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
        var coords = scaleCoordinates(location.position_x, location.position_y);
        location.scale = 'location';

        var kImage;
        if (location.type === 'wormhole') {
            kImage = new Kinetic.Sprite(imageResources.sprites.wormhole);

            kImage.stop(); //if not stopped prior to starting animation speed will stack
            kImage.start();
        } else {

            location.src = 'system-' + location.type;

            kImage = new Kinetic.Image({
                image: imageResources[config.imageMapping[location.src]],
                width: Math.sqrt(location.size) * config.drawScaleFactor[c.data.map.scale],
                height: Math.sqrt(location.size) * config.drawScaleFactor[c.data.map.scale]
            });
        }

        kImage.setHeight(Math.sqrt(location.size) * config.drawScaleFactor[c.data.map.scale]);
        kImage.setWidth(Math.sqrt(location.size) * config.drawScaleFactor[c.data.map.scale]);

        kImage.setX(coords.x - kImage.getWidth() / 2);
        kImage.setY(coords.y - kImage.getHeight() / 2);

        kImage.data = location;
        elements.layers.map.add(kImage);

        addLocationOverlay(location, kImage);
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

        var ships = $.extend({}, defaultText, {
            x: kImage.x + kImage.width,
            y: kImage.y - baseLineSpacing*2,
            text: system.system_ships || "0",
            fill: config.colours.neutralWhite.hex
        });


        var name = $.extend({}, defaultText, {
            x: kImage.x,
            y: kImage.y + kImage.height + baseLineSpacing,
            text: system.name,
            fill: (userSystems[system.id]) ? config.colours.ownedGreen.hex : config.colours.neutralWhite.hex
        });

        elements.layers.overlay.add(new Kinetic.Text(name));
        elements.layers.overlay.add(new Kinetic.Text(ships));
    }

    function addLocationOverlay(location, kImage) {
        if (location.type === 'wormhole') {
            return;
        }

        var color;

        if (!location.owner_id) {
            color = config.colours.neutralWhite.hex;
        } else if (location.owner_id === c.data.user.id) {
            color = config.colours.ownedGreen.hex;
        } else {
            color = config.colours.enemyRed.hex;
        }

        var name = $.extend({}, defaultText, {
            x: kImage.getX(),
            y: kImage.getY() + kImage.getHeight() + baseLineSpacing,
            text: location.name,
            fill: color
        });

        elements.layers.overlay.add(new Kinetic.Text(name));

        if ((location.category === 'star')) {
            return;
        }

        var iconY = kImage.getY() + (kImage.getHeight() / 3) - (baseFontSize + baseLineSpacing) * 2;

        var iconWidth = 20;
        var iconHeight = 20;
        var iconX = kImage.getX() - 30;

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
            x: kImage.x + kImage.width,
            y: kImage.y,
            text: fleet.size,
            fill: owned ? config.colours.ownedGreen.hex : config.colours.enemyRed.hex
        });

        if (fleet.destination_id) {

            var x1, y1, x2, y2;

            if (c.data.map.scale === 'system') {
                // x1 = fleet.position_x;
                // y1 = fleet.position_y;
                x2 = fleet.destination_x;
                y2 = fleet.destination_y;
            } else if (c.data.map.scale === 'sector') {
                // x1 = fleet.location_system_x;
                // y1 = fleet.location_system_y;
                x2 = fleet.destination_system_x;
                y2 = fleet.destination_system_y;
            }

            var destination = scaleCoordinates(x2, y2);
            x1 = kImage.x + kImage.width / 2;
            y1 = kImage.y + kImage.height / 2;

            var line = new Kinetic.Line({
                points: [x1, y1, destination.x, destination.y],
                stroke: owned ? config.colours.ownedGreen.hex : config.colours.enemyRed.hex,
                lineJoin: 'round',
                strokeWidth: 2,
                // tension: 1,
                dash: [10, 5]
            });
            elements.layers.overlay.add(line);
            overlay.push(line);
        } else {
            if (fleet.location_owner != fleet.owner_id) {
                //draw size text on left of fleet if on unowned planet
                size.x = kImage.x - 20;
            }
        }

        size = new Kinetic.Text(size);

        overlay.push(size);

        elements.layers.overlay.add(size);

        return overlay;
    }

    function animate(timestamp) {
        //timestamp is milliseconds since page was opened, not useful here
        time = new Date().getTime();

        simulateFleetMovement();
        animator = requestAnimationFrame(animate);
        elements.stage.drawScene();
    }

    function startUpdater() {
        if(!state) {
            updater = setInterval(getMapData, config.UPDATE_INTERVAL);
        }
        state = true;
    }

    function stopUpdater() {
        if(state) {
            clearInterval(updater);
        }
        state = false;        
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
