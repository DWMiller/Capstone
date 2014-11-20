CORE.createModule('logout', function(c) {
    'use strict';

    var p_properties = {
        id: 'logout'
    };

    var scope, elements;

    var listeners = {};

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'page-logout');

        elements = {
            logout: scope.find('#form-logout-logout')
        };

        bindEvents();

        scope.show();
    }

    function p_destroy() {
        scope.hide();

        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        scope.listen(listeners);
        scope.addEvent(elements.logout, 'click', logout);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        scope.removeEvent(elements.logout, 'click', logout);
    }

    /************************************ POSTS ************************************/

    function logout(event) {
        event.preventDefault();
        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    login: {
                        logout: {
                            placeholder: true
                        }
                    }
                }
            }
            
        });
        scope.notify({
            type: 'session-clear',
            data: {}
        });

        scope.notify({
            type: 'state-restart',
            data: {}
        });
    }

    /************************************ RESPONSES ************************************/
    /************************************ GENERAL FUNCTIONS ************************************/





    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
