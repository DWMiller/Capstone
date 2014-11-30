CORE.createModule('nothing', function(c, config) {
    'use strict';

    var p_properties = {
        id: 'nothing',
    };

    var scope;

    var listeners = {};

    var elements = {};

    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id);

        // elements.back = scope.find('#map-back');

        bindEvents();
        scope.show();
    }

    function p_destroy() {
        scope.hide();
        unbindEvents();
        elements = {};
        scope = null;

    }

    function bindEvents() {
        scope.listen(listeners);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
    }

    /************************************ API REQUESTS ************************************/


    /************************************ API RESPONSES ************************************/


    /************************************ FRAMEWORK LISTENERS ************************************/


    /************************************ UI Event Handlers ************************************/


    /************************************ GENERAL FUNCTIONS ************************************/

    return {

        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
