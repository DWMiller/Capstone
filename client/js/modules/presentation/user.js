CORE.createModule('user', function(c) {
    'use strict';

    var p_properties = {
        id: 'user',
        selector: 'module-user',
        listeners: {
            'user-update': updateUser
        }

    };

    var scope, elements;

    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb;

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
        $(scope.self()).on('click', '.research-start', triggerResearch);
    }

    function unbindEvents() {
        $(scope.self()).off('click', '.research-start', triggerResearch);
    }

    /************************************ POSTS ************************************/

    function triggerResearch(e) {
        var button = $(e.currentTarget);
        var researchType = button.data('research');

        c.notify({
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
        $(scope.self()).html(c.templates.userDetails(c.data.user).html());
    }

    // function openResearchMenu() {
    //     c.notify({
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
