CORE.createModule('login', function(c) {
    'use strict';

    var p_properties = {
        id: 'login'
    };

    var scope, elements;

    var listeners = {
        'login-success': loginSuccess,
        'login-failure': loginFailure,
        'register-success': login
    };

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'page-auth');

        elements = {
            email: scope.find('#form-auth-email'),
            password: scope.find('#form-auth-password'),
            login: scope.find('#form-auth-login'),
            password_mask: scope.find('#form-auth-password_mask'),
            msg: scope.find('#auth-msg')
        };

        togglePasswordMask();
        scope.show();

        bindEvents();
    }

    function p_destroy() {
        scope.hide();

        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        scope.listen(listeners);

        scope.addEvent(elements.login, 'click', login);
        scope.addEvent(elements.password_mask, 'click', togglePasswordMask);

    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        scope.removeEvent(elements.login, 'click', login);
        scope.removeEvent(elements.password_mask, 'click', togglePasswordMask);
    }

    /************************************ POSTS ************************************/

    function login(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    login: {
                        default: {
                            email: elements.email.value,
                            password: elements.password.value
                        }
                    }
                }
            }
        });
    }

    /************************************ RESPONSES ************************************/

    function loginSuccess(data) {
        scope.notify({
            type: 'data-set',
            data: {
                user: data.user,
                'user-locations': data.locations
            }
        });

        scope.notify({
            type: 'session-set',
            data: data.user.session
        });

        scope.notify({
            type: 'state-authenticated',
            data: {}
        });

        //Maybe shouldn't be here, but login success handler in other modules will first prior to user data being set above
        if (c.data.user.is_admin === "1") {
            c.startModule('admin');
        }
    }

    function loginFailure(errors) {
        var errorStr = '';

        errors.forEach(function(error) {
            errorStr += '<h2>' + error.title + '</h2>';
            errorStr += '<p>' + error.msg + '</p>';

        });

        elements.msg.innerHTML = errorStr;
    }

    /************************************ GENERAL FUNCTIONS ************************************/

    /**
     * Toggle masked state of password input
     * @return {[type]} [description]
     */
    function togglePasswordMask() {
        if (!elements.password_mask.checked) {
            $(elements.password).attr('type', 'password');
        } else {
            $(elements.password).attr('type', 'text');
        }
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
