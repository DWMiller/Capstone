dmf.createModule('lobby', function(c, config) {
    'use strict';

    var p_properties = {
        id: 'lobby',
        selector: 'module-lobby',
        listeners: {
            'queue-update': updateQueue
        }
    };

    var scope, elements;

    var gameChecker;

    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb;

        elements = {
            'queue-join': document.getElementById('queue-join'),
            'queue-leave': document.getElementById('queue-leave'),
            join: document.getElementById('queue-join-submit'),
            leave: document.getElementById('queue-leave-submit'),
        };

        bindEvents();
        scope.show();

        requestQueueUpdate();
        gameChecker = setInterval(requestQueueUpdate, config.UPDATE_INTERVAL);
    }

    function p_destroy() {
        clearInterval(gameChecker);

        scope.hide();
        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        c.dom.listen(elements.join, 'click', joinQueue);
        c.dom.listen(elements.leave, 'click', leaveQueue);
    }

    function unbindEvents() {
        c.dom.ignore(elements.join, 'click', joinQueue);
        c.dom.ignore(elements.leave, 'click', leaveQueue);
    }

    /************************************ POSTS ************************************/

    function joinQueue() {
        if (event.preventDefault) {
            event.preventDefault();
        }

        c.notify({
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

        c.notify({
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

    function requestQueueUpdate() {
        c.notify({
            type: 'server-post',
            data: {
                api: {
                    game: {
                        update: {
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

        c.notify('state-play');
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
