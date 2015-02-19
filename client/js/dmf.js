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
        classes: {},
        fn: {},
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
            this.extend(this.config, moduleConfig);
        },
        createModule: function(moduleID, creator) {
            if (typeof moduleID === 'string' && typeof creator === 'function') {

                moduleData[moduleID] = {
                    create: creator,
                    config: this.config[moduleID],
                    instance: null
                };

                this.log(1, "Module '" + moduleID + "' Registration : SUCCESS");
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
                }

                this.log(1, "Start Module '" + moduleID + "': SUCCESS");
            }
        },
        /**
         * Starts multiple modules
         * @param  {String[]} modules An array of the module ids to start
         * @return {[type]}         [description]
         */
        startModules: function(modules) {
            modules.forEach(this.startModule, this);
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
            var data = moduleData[moduleID];

            if (!data || !data.instance) {
                this.log(2, "Stop Module '" + moduleID + "': FAILED : module does not exist or has not been started");
                return;
            }


            if (data.instance.properties.listeners) {
                this.removeEvents(Object.keys(data.instance.properties.listeners), moduleID);
            }

            // Modules do not require a destroy function, use it if exists
            if (data.instance.destroy && typeof data.instance.destroy === 'function') {
                data.instance.destroy();
            }

            data.instance = null;
            delete data.instance;

            this.log(1, "Stop Module '" + moduleID + "': SUCCESS");

        },
        stopModules: function(modules) {
            modules.forEach(this.stopModule, this);
        },
        stopAllModules: function() {
            var moduleID;
            for (moduleID in moduleData) {
                if (moduleData.hasOwnProperty(moduleID)) {
                    this.stopModule(moduleID);
                }
            }
        },
        /**
         * Binds framework events to a module
         * @param  {[type]} evts Object containing event/function pairs to bind
         * @param  {string} mod  [description]
         * @return {[type]}      [description]
         */
        registerEvents: function(evts, moduleId) {
            if (!this.is_obj(evts) || !moduleId) {
                this.log(1, "Error registering events for: " + moduleId);
            }

            for (var eventKey in evts) {
                // Add event to event list if not yet added
                if (!this.events[eventKey]) {
                    this.events[eventKey] = {};
                }

                this.events[eventKey][moduleId] = evts[eventKey];
            }

        },
        notify: function(event) {
            // Allows shorthand, trigged via event name only without requiring data
            if (typeof event === 'string') {
                event = {
                    type: event,
                    data: {}
                };
            }

            var bindings = this.events[event.type];

            if (!bindings) {
                return;
            }

            var moduleId;
            for (moduleId in bindings) {
                bindings[moduleId](event.data);
            }
        },
        /**
         * Unsubscribes a single module from a set of events
         * @param  {[type]} evts [description]
         * @param  {[type]} mod  [description]
         * @return {[type]}      [description]
         */
        removeEvents: function(evts, mod) {
            // Should be a named function, but mod would not be available
            evts.forEach(function(event, index, array) {
                delete dmf.events[event][mod];
            });
        },

        log: function(severity, messages) {
            if (!debug) {
                return;
            }

            // If message is not an array, make it an array so we can traverse it
            if (!this.is_arr(messages)) {
                messages = [messages];
            }

            for (var i = 0; i < messages.length; i++) {
                console[(severity === 1) ? 'log' : (severity === 2) ? 'warn' : 'error'](JSON.stringify(messages[i], null, 4));
            };

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
                core.log(2,'Sandbox:self() deprecated, sandbox being removed');
                return CONTAINER;
            },
            find: function(selector) {
                core.log(2,'Sandbox:find() deprecated, sandbox being removed');
                return core.dom.find(selector, CONTAINER);
            },            
            hide: function(element) {
                core.log(2,'Sandbox:hide() deprecated, sandbox being removed');
                if (typeof element === 'undefined') {
                    element = CONTAINER;
                }

                core.dom.removeClass(element, 'visible');
                core.dom.addClass(element, 'hidden');
            },
            show: function(element) {
                core.log(2,'Sandbox:show() deprecated, sandbox being removed');
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
		timeout: 7000
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
        c.startModules(['system-server', 'system-data', 'system-localize']);
    }

    function destroy() {
        c.stopModules(['system-server', 'system-data', 'system-localize']);
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

        // Usage exampe for other modules 
        /**
         * here for testing purposes temporarily
         * @param  {[type]} lang [description]
         * @return {[type]}      [description]
         */
        // changeLanguage: function(lang) {
        //     this.notify({
        //         type: 'language-change',
        //         data: {
        //             language: lang
        //         }
        //     });
        // },



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

dmf.createModule('system-server', function(c, config) {
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
            timeout: config.timeout,
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

                c.notify({
                    type: 'server-response',
                    data: result
                });   
            })
            .fail(function(fail) {
                //console.log("error");
                c.notify({
                    type: 'server-fail',
                    data: fail
                });                
                
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
