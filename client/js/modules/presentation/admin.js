CORE.createModule('admin', function(c) {
    'use strict';

    var p_properties = {
        id: 'admin',
        selector: 'module-admin',
        listeners:{}
    };

    var scope, elements;

    var turnUpdater, maintainenceUpdater,combatTurnUpdater;

    /************************************ MODULE INITIALIZATION ************************************/
    /************************************ POSTS ************************************/
    /************************************ RESPONSES ************************************/
    /************************************ GENERAL FUNCTIONS ************************************/

    function p_initialize(sb) {
        scope = sb;

        elements = {
            game_end: scope.find('#admin-game_end'),
            game_start: scope.find('#admin-game_start'),
            stop: scope.find('#admin-module-stop'),
        };

        scope.show();
        bindEvents();

        turnUpdater = setInterval(triggerTurn, 15000);
        combatTurnUpdater = setInterval(triggerCombatTurn, 3000);
        maintainenceUpdater = setInterval(triggerMaintainence, 250);
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
        c.dom.listen(elements.game_end, 'click', endCurrentGame);
        c.dom.listen(elements.game_start, 'click', startNewGame);
        c.dom.listen(elements.stop, 'click', stop);

    }

    function unbindEvents() {
        c.dom.ignore(elements.game_end, 'click', endCurrentGame);
        c.dom.ignore(elements.game_start, 'click', startNewGame);
        c.dom.ignore(elements.stop, 'click', stop);

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

        c.notify({
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

        c.notify({
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
            c.notify({
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
            c.notify({
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
            c.notify({
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
