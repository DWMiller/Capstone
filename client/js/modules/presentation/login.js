dmf.createModule('login', function(c) {
    'use strict';

    var p_properties = {
        id: 'login',
        selector: 'page-auth',
        listeners: {
            'login-success': loginSuccess,
            'login-failure': loginFailure,
            'register-success': login
        }
    };

    var scope, elements;

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb;

        elements = {
            email: document.getElementById('form-auth-email'),
            password: document.getElementById('form-auth-password'),
            login: document.getElementById('form-auth-login'),
            password_mask: document.getElementById('form-auth-password_mask'),
            msg: document.getElementById('auth-msg')
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
        c.dom.listen(elements.login, 'click', login);
        c.dom.listen(elements.password_mask, 'click', togglePasswordMask);
    }

    function unbindEvents() {
        c.dom.ignore(elements.login, 'click', login);
        c.dom.ignore(elements.password_mask, 'click', togglePasswordMask);
    }

    /************************************ POSTS ************************************/

    function login(event) {
        if (event.preventDefault) {
            event.preventDefault();
        }

        c.notify({
            type: 'server-post',
            data: {
                api: {
                    login: {
                        login: {
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
        c.data.user = data.user;
        c.data['user-locations'] = data.locations;

        c.notify({
            type: 'session-set',
            data: data.user.session
        });

        c.notify('state-authenticated');

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
