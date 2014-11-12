CORE.createModule('user', function(c) {
    'use strict';

    var p_properties = {
        id: 'user'
    };

    var scope, elements;

    var listeners = {
        'user-update': updateUser
    };

    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-user');

        elements = {
            // header: scope.find('.module-header'),
            // contents: scope.find('.module-contents'),

        };

        bindEvents();
        scope.show();

        if(c.data.user) {
            refresh();
        }
    }

    function p_destroy() {
        scope.hide();
        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        scope.listen(listeners);
        // scope.addEvent(elements.close, 'click', hide);
        // $(elements.contents).on('click', '.upgrade-structure', upgradeStructure);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        // scope.removeEvent(elements.close, 'click', hide);
        // $(elements.contents).off('click', '.upgrade-structure', upgradeStructure);
    }

    /************************************ POSTS ************************************/


    /************************************ RESPONSES ************************************/

    function updateUser(data) {
        c.data.user = data;
        refresh();
    }

    /************************************ GENERAL FUNCTIONS ************************************/
    function refresh() {
        $(scope.self()).html(c.Templates.userDetails(c.data.user));
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
