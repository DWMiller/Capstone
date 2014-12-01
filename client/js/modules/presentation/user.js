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

        if (c.data.user) {
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
        // $(scope.self()).on('click', '.widget-research', openResearchMenu);
        $(scope.self()).on('click', '.research-start', triggerResearch);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        // $(scope.self()).off('click', '.widget-research', openResearchMenu);
        $(scope.self()).off('click', '.research-start', triggerResearch);
    }

    /************************************ POSTS ************************************/

    function triggerResearch(e) {
        var button = $(e.currentTarget);
        var researchType = button.data('research');
        
        scope.notify({
            type: 'server-post',
            data: {
                api: {
                    empire: {
                        research: {
                            type: researchType
                        }
                    }
                }
            }
        });
    }

    /************************************ RESPONSES ************************************/

    function updateUser(data) {
        c.data.user = data;
        refresh();
    }

    /************************************ GENERAL FUNCTIONS ************************************/

    function refresh() {
        $(scope.self()).html(c.Templates.userDetails(c.data.user).html());
    }

    // function openResearchMenu() {
    //     scope.notify({
    //         type: 'show-widget-research',
    //         data: true
    //     });        
    // }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
