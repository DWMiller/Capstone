dmf.createModule('logout', function(c) {
    'use strict';

    var p_properties = {
        id: 'logout',
        selector: 'page-logout',
        listeners:{}
    };

    var scope, elements;

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb;

        elements = {
            logout: document.getElementById('form-logout-logout')
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
        c.dom.listen(elements.logout, 'click', logout);
    }

    function unbindEvents() {
        c.dom.ignore(elements.logout, 'click', logout);
    }

    /************************************ POSTS ************************************/

    function logout(event) {
        event.preventDefault();
        c.notify({
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

        c.notify('session-clear');
        c.notify('state-restart');
    }

    /************************************ RESPONSES ************************************/
    /************************************ GENERAL FUNCTIONS ************************************/

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
