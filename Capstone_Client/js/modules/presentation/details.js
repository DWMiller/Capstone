CORE.createModule('details', function(c) {
    'use strict';

    var p_properties = {
        id: 'details'
    };

    var scope, elements;

    var listeners = {
        'details-show': showDetails,
        'location-update': locationUpdate,
        'details-hide': hide
    };

    var currentData;

    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-details');

        elements = {
            header: scope.find('.module-header'),
            contents: scope.find('.module-contents'),
            // close: scope.find('.close')
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
        scope.listen(listeners);
        // scope.addEvent(elements.close, 'click', hide);
        $(elements.contents).on('click', '.upgrade-structure', upgradeStructure);
        $(elements.contents).on('click', '.location-rename', renameLocation);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        // scope.removeEvent(elements.close, 'click', hide);
        $(elements.contents).off('click', '.upgrade-structure', upgradeStructure);
        $(elements.contents).off('click', '.location-rename', renameLocation);
    }

    /************************************ POSTS ************************************/

    function upgradeStructure(event) {
        var $this = $(event.target);
        var type = $this.attr('data-structure');

        scope.notify({
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

        scope.notify({
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
        if(typeof data === 'undefined') {
            return;
        }

        var oldData = currentData;

        hide();
         //instead of using passed data (a kineticjs object's data property, try to connect with core data storage)
        currentData = data;

        $(elements.header).text(data.name);

        var content = c.Templates[data.scale](data);

        $(elements.contents).html(content);

        if(data.fleetMove) {
            $(elements.contents).append('<h3 class="blink_me">Release fleet to issue a movement command to this location</h3>');
        }

        // Use transition effect if new object, instant update if same object as already selected
        if(oldData && oldData.id === data.id) {
            $(elements.contents).show();
        } else {
            $(elements.contents).fadeIn(600);        
        } 
    }

    function hide() {
        $(elements.contents).hide();
        currentData = null;
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
