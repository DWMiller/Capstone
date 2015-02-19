dmf.createModule('details', function(c) {
    'use strict';

    var p_properties = {
        id: 'details',
        selector: 'module-details',
        listeners: {
            'details-show': showDetails,
            'location-update': locationUpdate,
            'map-focus': showDetails,
            'details-hide': hide,
            'details-clear': clear
        }
    };

    var scope, elements;

    var currentData;

    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb;

        elements = {
            header: scope.find('.module-header'),
            contents: scope.find('.module-contents'),
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
        $(elements.contents).on('click', '.upgrade-btn', upgradeStructure);
        $(elements.contents).on('click', '.location-rename', renameLocation);
    }

    function unbindEvents() {
        $(elements.contents).off('click', '.upgrade-btn', upgradeStructure);
        $(elements.contents).off('click', '.location-rename', renameLocation);
    }

    /************************************ POSTS ************************************/

    function upgradeStructure(event) {
        var $this = $(event.target);
        var type = $this.attr('data-structure');

        c.notify({
            type: 'server-post',
            data: {
                api: {
                    empire: {
                        upgrade: {
                            location: currentData.id,
                            type: type
                        }
                    }
                }
            }
        });
    }

    function renameLocation(event) {
        var $this = $(event.currentTarget);
        var name = $this.prev('input').val();

        c.notify({
            type: 'server-post',
            data: {
                api: {
                    empire: {
                        rename: {
                            location: currentData.id,
                            name: name
                        }
                    }
                }
            }
        });
    }

    /************************************ RESPONSES ************************************/

    function locationUpdate(data) {
        $.extend(currentData, data);
        showDetails(currentData);
    }

    /************************************ GENERAL FUNCTIONS ************************************/
    function refresh() {
        showDetails();
    }

    function showDetails(data) {
        if (typeof data === 'undefined') {
            return;
        }

        var oldData = currentData;

        hide();
        //instead of using passed data (a kineticjs object's data property, try to connect with core data storage)
        currentData = data;

        $(elements.header).text(data.name);

        var content = c.templates[data.scale](data);

        $(elements.contents).html(content);

        if (data.fleetMove) {
            $(elements.contents).append('<h3 class="blink_me">Release fleet to issue a movement command to this location</h3>');
        }

        // Use transition effect if new object, instant update if same object as already selected
        if (oldData && oldData.id === data.id) {
            $(elements.contents).show();
        } else {
            $(elements.contents).fadeIn(600);
        }
    }

    function hide() {
        $(elements.contents).hide();
    }

    function clear() {
        currentData = null;
        elements.contents.innerHTML = '';
        hide();
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
