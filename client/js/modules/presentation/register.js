dmf.createModule('register', function(c) {
    'use strict';

    var p_properties = {
        id: 'register',
        selector: 'page-auth',
        listeners: {
            'register-failure': registerFailure
        }
    };

    var scope, elements;

    /************************************ MODULE INITIALIZATION ************************************/
    /************************************ POSTS ************************************/
    /************************************ RESPONSES ************************************/
    /************************************ GENERAL FUNCTIONS ************************************/

    function p_initialize(sb) {
        scope = sb;

        elements = {
            email: document.getElementById('form-auth-email'),
            password: document.getElementById('form-auth-password'),
            register: document.getElementById('form-auth-register'),
            msg: document.getElementById('auth-msg')
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
        c.dom.listen(elements.register, 'click', register);
    }

    function unbindEvents() {
        c.dom.ignore(elements.register, 'click', register);
    }

    function register(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        c.notify({
            type: 'server-post',
            data: {
                api: {
                    register: {
                        register: {
                            email: elements.email.value,
                            password: elements.password.value
                        }
                    }
                }
            }
        });
    }

    function registerFailure(errors) {
        var errorStr = '';

        errors.forEach(function(error) {
            errorStr += '<h2>' + error.title + '</h2>';
            errorStr += '<p>' + error.msg + '</p>';

        });

        elements.msg.innerHTML = errorStr;
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
