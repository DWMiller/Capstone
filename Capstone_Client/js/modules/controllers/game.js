CORE.createModule('game', function(c) {
    'use strict';

    var p_properties = {
        id: 'game'
    };

    var scope;

    var listeners = {
        'game-update': updateGame,
    };

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-game');
        bindEvents();
        getGameDetails();
        scope.show();
    }

    function p_destroy() {
        scope.hide();
        unbindEvents();
    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }

    /************************************ POSTS ************************************/

    function getGameDetails() {
        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    game: {
                        default: {
                            placeholder: true
                        }
                    }
                }
            }
        });
    }

    /************************************ RESPONSES ************************************/

    function updateGame(data) {
        scope.notify({
            type: 'data-set',
            data: {
                game: data.game
            }
        });
    }

    /************************************ GENERAL FUNCTIONS ************************************/

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
