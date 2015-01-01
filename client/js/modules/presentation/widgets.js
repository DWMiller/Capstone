CORE.createModule('widgets', function(c) {
    'use strict';

    var p_properties = {
        id: 'widgets',
        selector: 'module-game',
        listeners: {
            'show-widget-fleetSplitter': fleetSplitter,
        }
    };

    var scope, elements = {};

    var widgetData = {
        fleetSplitter: null
    };
    /************************************ MODULE INITIALIZATION ************************************/
    function p_initialize(sb) {
        scope = sb;

        elements.fleetSplitterContainer = $('#widget-fleetSplitter');
        elements.fleetSplitter = elements.fleetSplitterContainer.find('.slider');
        elements.fleetSplitConfirm = $('#widget-fleetSplitter .widget-button');
        elements.fleetSplitterLabel = $('#widget-fleetSplitter .widget-label');

        bindEvents();
    }

    function p_destroy() {
        unbindEvents();
        scope = null;
        elements = {};
    }

    function bindEvents() {
        elements.fleetSplitConfirm.on('click', confirmFleetSplit);
        elements.fleetSplitterContainer.on('input', '.slider', updateFleetSplitterLabel);
    }

    function unbindEvents() {
        elements.fleetSplitConfirm.off('click', confirmFleetSplit);
        elements.fleetSplitterContainer.off('input', '.slider', updateFleetSplitterLabel);
    }

    /************************************ POSTS ************************************/

    /************************************ RESPONSES ************************************/

    /************************************ Fleet Splitter ************************************/

    function fleetSplitter(data) {
        scope.show(elements.fleetSplitterContainer[0]);

        elements.fleetSplitter.prop({
            min: 0,
            max: (data.fleet.size * 1),
            value: Math.floor(data.fleet.size / 2),
        });

        updateFleetSplitterLabel();
        widgetData.fleetSplitter = data;
    }

    function updateFleetSplitterLabel(e) {
        var value;

        if (typeof e !== 'undefined') {
            value = e.currentTarget.value;
        } else {
            value = elements.fleetSplitter.val();
        }

        elements.fleetSplitterLabel.html(value + " Ships Selected");
    }

    function confirmFleetSplit() {
        widgetData.fleetSplitter.split = true;
        widgetData.fleetSplitter.splitSize = elements.fleetSplitter.val();

        c.modules.commands.instance.toggleCommand('fleetSplit', false);

        c.notify({
            type: 'fleet-move',
            data: widgetData.fleetSplitter
        });

        scope.hide(elements.fleetSplitterContainer[0]);
    }

    /************************************ Research ************************************/

    // function research() {
    //   scope.show(elements.research[0]);  
    // }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
    };

});
