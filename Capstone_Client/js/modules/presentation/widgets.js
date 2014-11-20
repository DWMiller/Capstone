CORE.createModule('widgets', function(c) {
    'use strict';

    var p_properties = {
        id: 'widgets'
    };

    var scope, elements = {};

    var listeners = {
        'show-widget-fleetSplitter': fleetSplitter
    };

    var widgetData = {
        fleetSplitter: null
    };
    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-game');

        elements.fleetSplitterContainer = $('#widget-fleetSplitter');
        elements.fleetSplitConfirm = $('#widget-fleetSplitter .widget-button');

        bindEvents();
    }

    function p_destroy() {
        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        scope.listen(listeners);
        elements.fleetSplitConfirm.on('click', confirmFleetSplit);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));
        elements.fleetSplitConfirm.off('click', confirmFleetSplit);
    }

    /************************************ POSTS ************************************/


    /************************************ RESPONSES ************************************/


    /************************************ GENERAL FUNCTIONS ************************************/

    function fleetSplitter(data) {
        scope.show(elements.fleetSplitterContainer[0]);
        elements.fleetSplitter = elements.fleetSplitterContainer.find('.slider').CircularSlider({
            min: 1,
            max: (data.fleet.size * 1),
            value: Math.floor(data.fleet.size / 2),
            shape: "Half Circle",
        });

        widgetData.fleetSplitter = data;
    }

    function confirmFleetSplit() {
        widgetData.fleetSplitter.split = true;
        widgetData.fleetSplitter.splitSize = elements.fleetSplitter.getValue();

        c.modules.commands.instance.toggleCommand('fleetSplit', false); 
        scope.notify({
            type: 'fleet-move',
            data: widgetData.fleetSplitter
        });

        scope.hide(elements.fleetSplitterContainer[0]);
        elements.fleetSplitter = null;
        elements.fleetSplitterContainer.find('.slider').html('');
    }


    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
