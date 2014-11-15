CORE.createModule('admin', function(c) {
    'use strict';

    var p_properties = {
        id: 'admin'
    };

    var scope, elements;

    var listeners = {};

    var turnUpdater, maintainenceUpdater;

    /************************************ MODULE INITIALIZATION ************************************/
    /************************************ POSTS ************************************/
    /************************************ RESPONSES ************************************/
    /************************************ GENERAL FUNCTIONS ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-admin');

        elements = {
            session_clear: scope.find('#admin-session_clear'),
            game_end: scope.find('#admin-game_end'),
            game_start: scope.find('#admin-game_start'),
            // map_generate: scope.find('#admin-map_generate'),
            stop: scope.find('#admin-module-stop'),
            'cron-income': scope.find('#cron-income'),
            'cron-ships': scope.find('#cron-ships')
        };

        scope.show();
        bindEvents();

        triggerTurn();
        turnUpdater = setInterval(triggerTurn,10000);
        maintainenceUpdater = setInterval(triggerMaintainence,1000);
    }

    function p_destroy(event) {
        if (event) {
            event.preventDefault();
        }

        scope.hide();

        unbindEvents();
        scope = null;
        elements = {};

        clearInterval(turnUpdater);
        clearInterval(maintainenceUpdater);
    }

    function bindEvents() {
        scope.listen(listeners);
        scope.addEvent(elements.session_clear, 'click', clearExpiredSessions);
        scope.addEvent(elements.game_end, 'click', endCurrentGame);
        scope.addEvent(elements.game_start, 'click', startNewGame);
        // scope.addEvent(elements.map_generate, 'click', generateMap);   
        scope.addEvent(elements.stop, 'click', stop);

    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        scope.removeEvent(elements.session_clear, 'click', clearExpiredSessions);
        scope.removeEvent(elements.game_end, 'click', endCurrentGame);
        scope.removeEvent(elements.game_start, 'click', startNewGame);
        // scope.removeEvent(elements.map_generate, 'click', generateMap);     
        scope.removeEvent(elements.stop, 'click', stop);

    }

    function stop(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        c.stopModule(p_properties.id);
    }

    function clearExpiredSessions(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    admin: {
                        clear: {
                            placeholder: true //can't serialize empty object
                        }
                    }
                }
            }
        });
    }

    function endCurrentGame(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    admin: {
                        end_game: {
                            placeholder: true
                        }
                    }
                }
            }
        });
    }

    function startNewGame(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    admin: {
                        new_game: {
                            // player_count: 10
                            placeholder: true
                        }
                    }
                }
            }
        });
    }


    function triggerTurn() {
        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    cron: {
                        executeTurn: {
                            placeholder: true
                        }                           
                    }
                }
            }
        });        
    }
  

    function triggerMaintainence() {
        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    cron: {
                        executeMaintainence: {
                            placeholder: true
                        }                           
                    }
                }
            }
        });        
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
