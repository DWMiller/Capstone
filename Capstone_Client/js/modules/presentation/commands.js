CORE.createModule('commands', function(c, config) {
    'use strict';

    var p_properties = {
        id: 'commands',
    };

    var scope;

    var listeners = {};

    var elements = {};

    var commands = {
        groupMove: false,
        fleetSplit: false
    };

    var keys = {
        16: 'groupMove', //shift
        83: 'fleetSplit' //s
    };
    /************************************ MODULE INITIALIZATION ************************************/

    function p_initialize(sb) {
        scope = sb.create(c, p_properties.id, 'module-commandBar');

        for (var command in commands) {
            elements[command] = $('#command-'+command);
        }

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

        $(scope.self()).on('click', '.command-btn', commandButtonClick);

        $(document).on('keydown', keyPressHandler);
        $(document).on('keyup', keyPressHandler);
    }

    function unbindEvents() {
        scope.ignore(Object.keys(listeners));

        $(scope.self()).off('click', '.command-btn', commandButtonClick);
        $(document).off('keydown', keyPressHandler);
        $(document).off('keyup', keyPressHandler);
    }

    /************************************ API REQUESTS ************************************/


    /************************************ API RESPONSES ************************************/


    /************************************ FRAMEWORK LISTENERS ************************************/


    /************************************ UI Event Handlers ************************************/

    function keyPressHandler(e) {
        var type = e.type;
        
        if (keys.hasOwnProperty(e.which)) {
            toggleCommand(keys[e.which],type === 'keyup' ? false : true);
        }
    }

    function commandButtonClick(e) {
        var btn = $(e.currentTarget);
        var command = btn.data('command');
        var active = btn.hasClass('active');

        toggleCommand(command,!active);
    }

    /************************************ GENERAL FUNCTIONS ************************************/

    function toggleCommand(command,state) {
        if(state) {
            elements[command].addClass('active');
            commands[command] = true;
        } else {
            elements[command].removeClass('active');
            commands[command] = false;
        }
    }

    return {
        properties: p_properties,
        initialize: p_initialize,
        destroy: p_destroy,
        options: commands,
        toggleCommand:toggleCommand
    };

});
