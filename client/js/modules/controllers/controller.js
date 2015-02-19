CORE.createModule('controller', function(c) {
        'use strict';

        var p_properties = {
            id: 'controller',
            listeners: {
                'state-startup': startup,
                'state-authenticated': authenticated,
                'state-play': play,
                'state-shutdown': shutdown,
                'state-restart': restart
            }
        };

        function p_initialize(sb) {
            startup();
        }

        function p_destroy() {
            c.stopAllModules();
        }

        function startup() {
            console.log('STATE: Startup');
            c.startModules(['login', 'register']);
    }

    function authenticated() {
        console.log('STATE: Authenticated');
        c.startModules(['logout', 'lobby']);
        c.stopModules(['login', 'register']);
}

function play() {
    console.log('STATE: Playing Game');

    c.stopModule('lobby');

    c.startModules(['game',
        'commands',
        'fleets',
        'animator',
        'widgets',
        'details',
        'user'
    ]);
}

function shutdown() {
    console.log('STATE: Shutting Down');

    c.stopModules(['lobby',
        'login',
        'logout',
        'register',
        'game',
        'commands',
        'fleets',
        'animator',
        'widgets',
        'details',
        'admin',
        'user',
        'admin'
    ]);
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
