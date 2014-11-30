CORE.createModule('register', function(c) {
    'use strict';

    var p_properties = {
        id: 'register'
    };

    var scope, elements;

    var listeners = {
        'register-failure': registerFailure
    };

/************************************ MODULE INITIALIZATION ************************************/
/************************************ POSTS ************************************/
/************************************ RESPONSES ************************************/
/************************************ GENERAL FUNCTIONS ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'page-auth');

        elements = {
            email: scope.find('#form-auth-email'),
            password: scope.find('#form-auth-password'),
            register: scope.find('#form-auth-register'),
            msg: scope.find('#auth-msg')
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
        scope.addEvent(elements.register, 'click', register);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        scope.removeEvent(elements.register, 'click', register);
    }

    function register(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    register: {
                        default: {
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
            errorStr += '<h2>'+error.title+'</h2>';
            errorStr += '<p>'+error.msg+'</p>';

        });

        elements.msg.innerHTML = errorStr;
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
