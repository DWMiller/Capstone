CORE.createModule('lobby', function(c) {
    'use strict';

    var p_properties = {
        id: 'lobby'
    };

    var scope, elements;

    var listeners = {
        'queue-update': updateQueue
    };

    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-lobby');

        elements = {
            'queue-join': scope.find('#queue-join'),
            'queue-leave': scope.find('#queue-leave'),
            // 'queue-play': scope.find('#queue-play'),
            join: scope.find('#queue-join-submit'),
            leave: scope.find('#queue-leave-submit'),
            // play: scope.find('#queue-play-submit')
        };

        bindEvents();
        scope.show();

        updateChoices();
    }

    function p_destroy() {
        scope.hide();
        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        scope.listen(listeners);
        scope.addEvent(elements.join, 'click', joinQueue);
        scope.addEvent(elements.leave, 'click', leaveQueue);
        // scope.addEvent(elements.play, 'click', playGame);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        scope.removeEvent(elements.join, 'click', joinQueue);
        scope.removeEvent(elements.leave, 'click', leaveQueue);
        // scope.removeEvent(elements.play, 'click', playGame);
    }

    /************************************ POSTS ************************************/

    function joinQueue() {
        if (event.preventDefault) {
            event.preventDefault();
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    game: {
                        join_queue: {
                            placeholder: true
                        }
                    }
                }
            }
        });
    }

    function leaveQueue() {
        if (event.preventDefault) {
            event.preventDefault();
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    game: {
                        leave_queue: {
                            placeholder: true
                        }
                    }
                }
            }
        });
    }

    /************************************ RESPONSES ************************************/

    function updateQueue(data) {
        CORE.data.user.status = data['user-status'];
        updateChoices();
    }

    /************************************ GENERAL FUNCTIONS ************************************/

    function updateChoices() {
        // console.log(CORE.data.user.status);

        switch (parseInt(CORE.data.user.status)) {
            case 0: // account not activated
                break;
            case 1: // Active account
                showQueue();
                break;
            case 2: // Queued for next game
                showQueued();
                break;
            case 3: // Playing current game
                playGame();
                break;
            case 4: // Banned
                break;
        }
    }

    function showQueue() {
        scope.hide(elements['queue-leave']);
        scope.show(elements['queue-join']);
    }

    function showQueued() {
        scope.hide(elements['queue-join']);
        scope.show(elements['queue-leave']);
    }

    function playGame() {
        scope.hide(elements['queue-join']);
        scope.hide(elements['queue-leave']);

        scope.notify({
            type: 'state-play',
            data: {}
        });
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
