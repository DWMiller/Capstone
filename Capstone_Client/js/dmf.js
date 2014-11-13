

/**
 * [CORE description]
 * @version  0.15
 */
var CORE = function() {
    'use strict';
    var moduleData = {}
    var debug = false;

    return {
        container: null,
        modules: moduleData,
        config: {},
        data: {},
        events: {},
        /**
         * Triggers starter logic for all game modules
         * @return {[type]} [description]
         */
        activate: function(settings) {
            if (typeof settings.debug !== 'undefined') {
                this.debug(settings.debug);
            }

            if (typeof settings.container !== 'undefined') {
                this.container = document.querySelector(settings.container);
            } else {
                 this.container = document.querySelector('body');
            }

            this.startModule('system-controller');

            if (typeof settings.startup !== 'undefined') {
                this.startModule(settings.startup);
            }
        },
        debug: function(on) {
            if (on !== 'undefined') {
                debug = on ? true : false;
            } else {
                debug = !debug;
            }
        },
        extendConfig: function(moduleConfig) {
            $.extend(true, this.config, moduleConfig);
        },
        createModule: function(moduleID, creator) {
            var temp;
            if (typeof moduleID === 'string' && typeof creator === 'function') {

                temp = creator(this);
                if (temp.initialize && typeof temp.initialize === 'function' && temp.destroy && typeof temp.destroy === 'function') {
                    temp = null;
                    moduleData[moduleID] = {
                        create: creator,
                        config: this.config[moduleID],
                        instance: null
                    };
                    this.log(1, "Module '" + moduleID + "' Registration : SUCCESS");
                } else {
                    this.log(2, "Module '" + moduleID + "' Registration : FAILED : instance has no initialize or destroy functions");
                }
            } else {
                this.log(2, "Module '" + moduleID + "' Registration : FAILED : one or more arguments are of incorrect type");
            }
        },
        getModule: function(moduleID) {
            var mod = moduleData[moduleID];
            if (mod) {
                return mod.create(this, mod.config);
            } else {
                return false;
            }
        },
        startModule: function(moduleID) {
            var mod = moduleData[moduleID];

            if (mod) {
                mod.instance = this.getModule(moduleID);
                mod.instance.initialize(this.Sandbox);
                this.log(1, "Start Module '" + moduleID + "': SUCCESS");
            }
        },
        startAllModules: function() {
            var moduleID;
            for (moduleID in moduleData) {
                if (moduleData.hasOwnProperty(moduleID)) {
                    this.startModule(moduleID);
                }
            }
        },
        stopModule: function(moduleID) {
            var data;
            if ((data = moduleData[moduleID]) && data.instance) {
                data.instance.destroy();
                data.instance = null;
                this.log(1, "Stop Module '" + moduleID + "': SUCCESS");
            } else {
                this.log(2, "Stop Module '" + moduleID + "': FAILED : module does not exist or has not been started");
            }
        },
        stopAllModules: function() {
            var moduleID;
            for (moduleID in moduleData) {
                if (moduleData.hasOwnProperty(moduleID)) {
                    this.stopModule(moduleID);
                }
            }
        },
        registerEvents: function(evts, mod) {
            if (this.is_obj(evts) && mod) {
                for (var eventKey in evts) {
                    if (!this.events[eventKey]) {
                        this.events[eventKey] = {};
                    }
                    this.events[eventKey][mod] = evts[eventKey];
                }
            } else {
                this.log(1, "Error registering events for: " + mod);
            }
        },
        notify: function(evt) {
            if (this.is_obj(evt) && evt.type) {
                this.triggerEvent(evt);
            }
        },
        listen: function(evts) {
            this.registerEvents(evts, moduleID);
        },
        ignore: function(evts) {
            if (!this.is_arr(evts)) {
                var e = evts;
                evts = [e];
            }

        this.removeEvents(evts, moduleID);
        },

        triggerEvent: function(evt) {
            var bindings = this.events[evt.type];
            if (!bindings) {
                return;
            }

            for (var binding in bindings) {
                bindings[binding](evt.data);
            }
        },
        /**
         * Unsubscribes a single module from a set of events
         * @param  {[type]} evts [description]
         * @param  {[type]} mod  [description]
         * @return {[type]}      [description]
         */
        removeEvents: function(evts, mod) {
            evts.forEach(function(event, index, array) {
                delete CORE.events[event][mod];
            });
        },
        log: function(severity, message) {
            if (debug) {

                if (!this.is_arr(message)) {
                    message = [message];
                }

                for (var i = 0; i < message.length; i++) {
                    console[(severity === 1) ? 'log' : (severity === 2) ? 'warn' : 'error'](JSON.stringify(message[i], null, 4));
                };
            }
        },
        changeLanguage: function(lang) {
            var event = {
                type: 'language-change',
                data: {
                    language: lang
                }
            };
            this.triggerEvent(event);
        },
        is_arr: function(arr) {
            return jQuery.isArray(arr);
        },
        is_obj: function(obj) {
            return jQuery.isPlainObject(obj);
        },
        extend: function(targetObject, extendObject) {
            jQuery.extend(true, targetObject, extendObject);

        }
    };
}()

CORE.dom = function() {
    return {
        find: function(selector, context) {
            var ret = {};

            if (context) {
                ret = context.querySelector(selector);
            } else {
                ret = document.querySelector(selector);
            }
            return ret;
        },
        bind: function(element, evt, fn) {
            if (element && evt) {
                if (typeof evt === 'function') {
                    fn = evt;
                    evt = 'click';
                }
                element.addEventListener(evt, fn)
            } else {
                // log wrong arguments
            }
        },
        unbind: function(element, evt, fn) {
            if (element && evt) {
                if (typeof evt === 'function') {
                    fn = evt;
                    evt = 'click';
                }
                element.removeEventListener(evt, fn)
            } else {
                // log wrong arguments
            }
        },
        addClass: function(element, className) {
            jQuery(element).addClass(className);
        },
        removeClass: function(element, className) {
            jQuery(element).removeClass(className);
        },
        emptyNode: function(element) {
            if (element instanceof jQuery) {
                element.html('');
            } else {
                while (element.firstChild) {
                    element.removeChild(element.firstChild);
                }
            }
        },
        append: function(element, toAppend) {
            if (!(element instanceof jQuery)) {
                element = $(element);
            }

            if (!(toAppend instanceof jQuery)) {
                toAppend = $(toAppend);
            }

            element.append(toAppend);
        }
    }
}();

CORE.Sandbox = {
    create: function(core, moduleID, module_selector) {
        //Should allow any selector rather than only IDs, but will break existing modules
        var CONTAINER = document.getElementById(module_selector) || core.container;
        return {
            self: function() {
                return CONTAINER;
            },
            find: function(selector) {
                return core.dom.find(selector, CONTAINER);
            },
            addEvent: function(element, type, fn) {
                core.dom.bind(element, type, fn);
            },
            removeEvent: function(element, type, fn) {
                core.dom.unbind(element, type, fn);
            },
            // Deprecated as sandbox component, used within CORE now
            notify: function(evt) {
                console.log('"notify" function access via sandbox is deprecated, access via CORE instead ');
                if (core.is_obj(evt) && evt.type) {
                    core.triggerEvent(evt);
                }
            },
            // Deprecated as sandbox component, used within CORE now
            listen: function(evts) {
                console.log('"listen" function access via sandbox is deprecated, access via CORE instead ');
                core.registerEvents(evts, moduleID);
            },
            // Deprecated as sandbox component, used within CORE now
            ignore: function(evts) {
                console.log('"ignore" function access via sandbox is deprecated, access via CORE instead ');
                if (!core.is_arr(evts)) {
                    var e = evts;
                    evts = [e];
                }

                core.removeEvents(evts, moduleID);
            },
            hide: function(element) {
                if (typeof element === 'undefined') {
                    element = CONTAINER;
                }

                core.dom.removeClass(element, 'visible');
                core.dom.addClass(element, 'hidden');
            },
            show: function(element) {
                if (typeof element === 'undefined') {
                    element = CONTAINER;
                }

                core.dom.addClass(element, 'visible');
                core.dom.removeClass(element, 'hidden');
            }
        };
    }
}

/**
 * Base config file
 * Not loaded in a specific order, so may override other config files with matching fields
 * Provided as a location for general config settings if an individual file is not appropriate or not preferred.
 * @type {Object}
 */
CORE.extendConfig({
	'system-server': {
		endpoint: 'http://127.0.0.1:8080/',
	},	
	'system-localize': {
		default_language: 'en',
		path:'js/localization/',
		ext: '.lang.json'		
	}	
});
CORE.createModule('system-controller', function(c) {
    'use strict';

    var p_properties = {
        id: 'system-controller'
    };

    var scope;

    var listeners = {};

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id);
        c.startModule('system-server');
        c.startModule('system-data');
        c.startModule('system-localize');

        bindEvents();
    }

    function p_destroy() {
        unbindEvents();
        c.stopModule('system-server');
        c.stopModule('system-data');
        c.stopModule('system-localize');
    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});

CORE.createModule('system-data', function(c) {
    'use strict';

    var p_properties = {
        id: 'system-data'
    };

    var scope;

    var listeners = {
        'data-set': setData,
        'data-clear': clearData
    };

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id);
        bindEvents();
    }

    function p_destroy() {
        unbindEvents();
    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }

    function setData(content) {
        c.extend(c.data, content);

        //Maybe work out a way to customize event based on data updated
        scope.notify({
            type: 'data-update',
            data: content
        });
    }

    function clearData(field) {
        if (typeof field !== 'undefined') {
            c.data[field] = {};
            delete c.data[field];
        } else {
            c.data = {};
            delete c.data;
        }
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});

CORE.createModule('system-localize', function(c,config) {
    'use strict';

    var p_properties = {
        id: 'system-localize'
    };

    var scope, elements;

    var listeners = {
        'language-change': changeLanguage
    };

    var p_languages = {}; // will contain lazy loaded language data

    var language; // string representing key of currently active language (default 'en' for english)

    // var p_data = {}; //will contain localized language data for the currently selected language only


    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id);
        bindEvents();

        language = config.default_language;
        getLanguage();
    }

    function p_destroy() {
        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }


    function changeLanguage(data) {
        language = data.language;
        getLanguage();
    }

    /**
     * Retrieve language data for specific language
     * @return {[type]}      [description]
     */
    function getLanguage() {
        // If language is not loaded, retrieve it then update.
        // If language is already loaded, update only.

        if (!p_languages[language]) {
            $.getJSON(config.path + language + config.ext).done(function(response) {
                p_languages[language] = response;
                updateLanguage();
            });
        } else {
            updateLanguage();
        }
    }

    function updateLanguage() {
        console.log('Language changed to ' + language);

        scope.notify({
            type: 'data-set',
            data: {
                language: p_languages[language]
            }
        });
        translate();
    }

    /**
     * Convert all text to localized language values
     * @return {[type]} [description]
     */
    function translate() {
        var elements = document.querySelectorAll('.localize');

        for (var i = 0; i < elements.length; i++) {
            localizeElement(elements[i]);
        }
    }

    function localizeElement(element) {
        var key = element.getAttribute("data-localize");

        var text = p_getLocalizedText(key);

        if (text) {
            switch (element.tagName) {
                case 'INPUT':
                    element.value = text;
                    break;
                default:
                    element.innerHTML = text;
            }
        } else {
            return false;
        }
    }

    function p_getLocalizedText(key) {
        if (c.data.language[key]) {
            return c.data.language[key];
        } else {
            return false;
        }
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };
});

CORE.createModule('system-server', function(c) {
    'use strict';

    var p_properties = {
        id: 'system-server'
    };

    var config, scope, session;

    var listeners = {
        'server-request': request,
        'server-post': post,
        'session-set': setSession,
        'session-clear': clearSession
    };

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id);
        config = CORE.config[p_properties.id];
        bindEvents();
    }

    function p_destroy() {
        unbindEvents();
    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }

    function request() {
        //TODO - for GET requests
    }
    
    function post(data) {
        c.log(1, ['REQUEST', data]);

        if (session) {
            data.session = session;
        }

        var settings = {
            url: config.endpoint,
            data: JSON.stringify(data),
            type: 'POST',
            dataType: 'json',
            crossDomain: true,
        };

        return $.ajax(settings)
            .done(function(result) {
                c.log(1, ['RESPONSE', result]);

                for (var obj in result) {
                    scope.notify({
                        type: obj,
                        data: result[obj]
                    });
                }
            })
            .fail(function() {
                //console.log("error");
            })
            .always(function(result) {
                // console.log("complete");
            });
    }

    function setSession(sessionString) {
        session = sessionString;
    }

    function clearSession() {
        session = null;
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
