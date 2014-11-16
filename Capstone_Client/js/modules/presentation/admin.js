CORE.createModule('admin', function(c) {
    'use strict';

    var p_properties = {
        id: 'admin'
    };

    var scope, elements;

    var listeners = {};

    var turnUpdater, maintainenceUpdater,combatTurnUpdater;

    /************************************ MODULE INITIALIZATION ************************************/
    /************************************ POSTS ************************************/
    /************************************ RESPONSES ************************************/
    /************************************ GENERAL FUNCTIONS ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-admin');

        elements = {
            game_end: scope.find('#admin-game_end'),
            game_start: scope.find('#admin-game_start'),
            stop: scope.find('#admin-module-stop'),
        };

        scope.show();
        bindEvents();

        turnUpdater = setInterval(triggerTurn, 10000);
        combatTurnUpdater = setInterval(triggerCombatTurn, 3000);
        maintainenceUpdater = setInterval(triggerMaintainence, 1000);
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
        clearInterval(combatTurnUpdater);
        clearInterval(maintainenceUpdater);
    }

    function bindEvents() {
        scope.listen(listeners);
        scope.addEvent(elements.game_end, 'click', endCurrentGame);
        scope.addEvent(elements.game_start, 'click', startNewGame);
        scope.addEvent(elements.stop, 'click', stop);

    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        scope.removeEvent(elements.game_end, 'click', endCurrentGame);
        scope.removeEvent(elements.game_start, 'click', startNewGame);
        scope.removeEvent(elements.stop, 'click', stop);

    }

    function stop(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        c.stopModule(p_properties.id);
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
        if (c.data.user.status == 3) {
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
    }

    function triggerCombatTurn() {
        if (c.data.user.status == 3) {
            scope.notify({
                type: 'server-post',
                data: {
                    api: {
                        cron: {
                            executeCombatTurn: {
                                placeholder: true
                            }
                        }
                    }
                }
            });
        }
    }

    function triggerMaintainence() {
        if (c.data.user.status == 3) {
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
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
