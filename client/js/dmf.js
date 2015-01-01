/**
 * [CORE description]
 */
var dmf = function() {
    'use strict';
    var moduleData = {}
    var debug = false;

    return {
        container: null,
        modules: moduleData,
        config: {},
        data: {},
        events: {},
        templates: {},
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
                // if (temp.initialize && typeof temp.initialize === 'function' && temp.destroy && typeof temp.destroy === 'function') {
                temp = null;
                moduleData[moduleID] = {
                    create: creator,
                    config: this.config[moduleID],
                    instance: null
                };
                this.log(1, "Module '" + moduleID + "' Registration : SUCCESS");
                // } else {
                //     this.log(2, "Module '" + moduleID + "' Registration : FAILED : instance has no initialize or destroy functions");
                // }

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

                // Modules do not require an initializing function, use it if exists
                if (mod.instance.initialize && typeof mod.instance.initialize === 'function') {
                    mod.instance.initialize(this.Sandbox.create(this, mod.instance.properties));
                } 

                if (mod.instance.properties.listeners) {
                    this.registerEvents(mod.instance.properties.listeners, moduleID);
                    console.log("Events Registered - " + moduleID)
                }

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

                if (data.instance.properties.listeners) {
                    console.log("Events Ignored - " + moduleID)
                    this.removeEvents(Object.keys(data.instance.properties.listeners), moduleID);
                }

                // Modules do not require a destroy function, use it if exists
                if (data.instance.destroy && typeof data.instance.destroy === 'function') {
                    data.instance.destroy();
                } else {
                    // define scope/sandbox here if initialization function is not present
                    if (data.instance.scope) {
                        data.instance.scope = null;
                    }
                    // this.dispose(data.instance);
                }

                data.instance = null;
                delete data.instance;

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
        //listen & ignore should be here, but moduleID is not available and would need to be passed from the module
        // listen: function(evts) {
        //     this.registerEvents(evts, moduleID);
        // },
        // ignore: function(evts) {
        //     if (!this.is_arr(evts)) {
        //         var e = evts;
        //         evts = [e];
        //     }

        // this.removeEvents(evts, moduleID);
        // },

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
                delete dmf.events[event][mod];
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
            // dispose: function(obj) {
            //     for (var o in obj)
            //         if (isNaN(parseInt(o))) {
            //             this.dispose(obj[o]);
            //         }
            //     delete obj; 
            // }
    };
}()

//Deprecated namespace usage, delete in future versions
var CORE = dmf;

dmf.dom = function() {
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
        listen: function(element, evt, fn) {
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
        ignore: function(element, evt, fn) {
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
        toggleClass: function(element, toggleClass) {
            jQuery(element).toggleClass(toggleClass);
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
dmf.Sandbox = {
    create: function(core, moduleProperties) {
        var moduleID = moduleProperties.id || null;
        var module_selector = moduleProperties.selector || null
 
        //Should allow any selector rather than only IDs, but will break existing modules
        var CONTAINER = document.getElementById(module_selector) || core.container;
        return {
            self: function() {
                return CONTAINER;
            },
            find: function(selector) {
                return core.dom.find(selector, CONTAINER);
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
dmf.extendConfig({
	'system-server': {
		endpoint: 'http://127.0.0.1:8080/',
	},	
	'system-localize': {
		default_language: 'en',
		path:'assets/localization/',
		ext: '.lang.json'		
	}	
});
dmf.createModule('system-controller', function(c) {
    'use strict';

    var properties = {
        id: 'system-controller',
        listeners: {}
    };

    function initialize(scope) {
        c.startModule('system-server');
        c.startModule('system-data');
        c.startModule('system-localize');
    }

    function destroy() {
        c.stopModule('system-server');
        c.stopModule('system-data');
        c.stopModule('system-localize');
    }

    return {
        properties: properties,
        initialize: initialize,
        destroy: destroy,
    };

});

// dmf.createModule('system-data', function(c) {
//     'use strict';

//     var properties = {
//         id: 'system-data',
//         listeners:{
//             'data-set': setData,
//             'data-clear': clearData
//         }
//     };

//     var scope;

//     function initialize(sb) {
//         scope = sb.create(c, properties.id);
//     }

//     function destroy() {}

//     function setData(content) {
//         console.log('setData: Data module is deprecated, too be removed or redesigned in future build');
//         c.extend(c.data, content);

//         //Maybe work out a way to customize event based on data updated
//         c.notify({
//             type: 'data-update',
//             data: content
//         });
//     }

//     function clearData(field) {
//         console.log('clearData: Data module is deprecated, too be removed or redesigned in future build');
//         if (typeof field !== 'undefined') {
//             c.data[field] = {};
//             delete c.data[field];
//         } else {
//             c.data = {};
//             delete c.data;
//         }
//     }

//     return {
//         properties: properties,
//         initialize: initialize,
//         destroy: destroy,
//     };

// });

dmf.createModule('system-localize', function(c, config) {
    'use strict';

    var properties = {
        id: 'system-localize',
        listeners:{
            'language-change': changeLanguage
        }
    };

    var elements;

    var p_languages = {}; // will contain lazy loaded language data

    var language; // string representing key of currently active language (default 'en' for english)

    // var p_data = {}; //will contain localized language data for the currently selected language only


    function initialize(scope) {
        language = config.default_language;
        getLanguage();
    }

    function destroy() {
        elements = {};
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

        c.extend(c.data, {
            language: p_languages[language]
        });

        // c.notify({
        //     type: 'data-set',
        //     data: {
        //         language: p_languages[language]
        //     }
        // });

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

        var text = getLocalizedText(key);

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

    function getLocalizedText(key) {
        if (c.data.language[key]) {
            return c.data.language[key];
        } else {
            return false;
        }
    }

    return {
        properties: properties,
        initialize: initialize,
        destroy: destroy,
    };
});

dmf.createModule('system-server', function(c,config) {
    'use strict';

    var properties = {
        id: 'system-server',
        listeners: {
            'server-request': request,
            'server-post': post,
            'session-set': setSession,
            'session-clear': clearSession
        }
    };

    var session;

    // function initialize(scope) {
    // }

    // function destroy() {}

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
                    c.notify({
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
        properties: properties,
        // initialize: initialize,
        // destroy: destroy
    };

});
