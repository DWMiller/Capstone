CORE.createModule('controller', function(c) {
    'use strict';

    var p_properties = {
        id: 'controller'
    };

    var scope;

    var listeners = {
        'state-startup': startup,
        'state-authenticated': authenticated,
        'state-play': play,
        'state-shutdown': shutdown,
        'state-restart': restart
    };


    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id);
        bindEvents();
        startup();
    }

    function p_destroy() {
        unbindEvents();
        c.stopAllModules();
    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }

    function startup() {
        console.log('STATE: Startup');
        c.startModule('login');
        c.startModule('register');
    }

    function authenticated() {
        console.log('STATE: Authenticated');
        c.startModule('logout');
        c.startModule('lobby');
        c.stopModule('login'); 
        c.stopModule('register'); 
    }

    function play() {
        console.log('STATE: Playing Game');
        c.stopModule('lobby');
        c.startModule('game');
        c.startModule('commands');
        c.startModule('fleets');
        c.startModule('animator'); 
        c.startModule('widgets'); 
        c.startModule('details');
        c.startModule('user');
    }

    function shutdown() {
        console.log('STATE: Shutting Down');
        c.stopModule('lobby');
        c.stopModule('login');
        c.stopModule('logout');
        c.stopModule('register');
        c.stopModule('game');
        c.stopModule('commands');
        c.stopModule('fleets');        
        c.stopModule('animator');
        c.stopModule('widgets');
        c.stopModule('details');
        c.stopModule('admin');
        c.stopModule('user');
        c.stopModule('admin');
    }

    function restart() {
        shutdown();
        startup();
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
