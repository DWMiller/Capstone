CORE.Templates = function() {
    'use strict';

    // var vals = {
    //     'MINE_BASE' : 1,
    //     'SHIPYARD_BASE' : 1.5,
    //     'LAB_BASE' : 2
    // };

    return {
        location: function(data) {
            var structureCount = data.mines*1+data.shipyards*1+data.labs*1;

            var owned = (data.owner_id === CORE.data.user.id);
            var $container = $('<div>');

            var $row = $('<p>');
            $('<span>',{class:'label'}).text('Type:').appendTo($row);
            $('<span>',{class:'value'}).text(CORE.data.language.map[data.type]).appendTo($row);
            $container.append($row);
            
            // $row = $('<p>');
            // $('<span>',{class:'label'}).text(CORE.data.language.name).appendTo($row);
            // $('<span>',{class:'value'}).text(data.name).appendTo($row);
            // $container.append($row);

            $row = $('<p>');
            $('<span>',{class:'label'}).text("Position:").appendTo($row);
            $('<span>',{class:'value'}).text("( " + data.position_x + ", " + data.position_y + " )").appendTo($row);
            $container.append($row);
            
            $row = $('<p>');
            $('<span>',{class:'label'}).text("Resources:").appendTo($row);
            $('<span>',{class:'value'}).text(data.resources).appendTo($row);
            $container.append($row);
            
            $row = $('<p>');
            $('<span>',{class:'label'}).text("Size:").appendTo($row);
            $('<span>',{class:'value'}).text(data.size).appendTo($row);
            $container.append($row);

            $('<hr>').appendTo($container);
            
            $row = $('<p>');
            $('<span>',{class:'label'}).text("Owner:").appendTo($row);
            $('<span>',{class:'value'}).text(data.owner_id||'Unclaimed').appendTo($row);
            $container.append($row);                                    

            $row = $('<p>');
            $('<span>',{class:'label'}).text(CORE.data.language.structure.mines+": ").appendTo($row);
            $('<span>',{class:'value'}).text(data.mines).appendTo($row);
            if(owned && data.resources > 0) {
                $('<button>',{class:'upgrade-structure', 'data-structure': 'mine'}).text('Upgrade - ' + data['upgrade-cost-mine']).appendTo($row);
            }
            $container.append($row);           

            $row = $('<p>');
            $('<span>',{class:'label'}).text(CORE.data.language.structure.shipyards+": ").appendTo($row);
            $('<span>',{class:'value'}).text(data.shipyards).appendTo($row);
            if(owned) {
                $('<button>',{class:'upgrade-structure', 'data-structure': 'shipyard'}).text('Upgrade - ' + data['upgrade-cost-shipyard']).appendTo($row);
            }
            $container.append($row);   
            
            $row = $('<p>');
            $('<span>',{class:'label'}).text(CORE.data.language.structure.labs+": ").appendTo($row);
            $('<span>',{class:'value'}).text(data.labs).appendTo($row);
            if(owned) {
                $('<button>',{class:'upgrade-structure', 'data-structure': 'lab'}).text('Upgrade - ' + data['upgrade-cost-lab']).appendTo($row);
            }
            $container.append($row);     

            if(owned) {
                $row = $('<p>');
                $('<input>',{type:'text', value: data.name}).appendTo($row);
                $('<button>',{class:'location-rename'}).text('Rename').appendTo($row);
                $container.append($row);   
            }

            return $container;                      
        },

        system: function(data) {
            var $container = $('<div>');

            var $row = $('<p>');
            $('<span>',{class:'label'}).text("Type:").appendTo($row);
            $('<span>',{class:'value'}).text(CORE.data.language.map[data.type]).appendTo($row);
            $container.append($row);

            // $row = $('<p>');
            // $('<span>',{class:'label'}).text(CORE.data.language.name).appendTo($row);
            // $('<span>',{class:'value'}).text(data.name).appendTo($row);
            // $container.append($row);

            $row = $('<p>');
            $('<span>',{class:'label'}).text("Position:").appendTo($row);
            $('<span>',{class:'value'}).text("( " + data.position_x + ", " + data.position_y + " )").appendTo($row);
            $container.append($row);

             $row = $('<p>');
            $('<span>',{class:'label'}).text("Size:").appendTo($row);
            $('<span>',{class:'value'}).text(data.size).appendTo($row);
            $container.append($row);

            $('<hr>').appendTo($container);
            return $container;
        },

        userDetails: function(data) {
            var $container = $('<div>');

            var $row = $('<p>');
            $('<span>',{class:'label'}).text("Resources: ").appendTo($row);
            $('<span>',{class:'value'}).text(data.resources).appendTo($row);
            $container.append($row);

            $row = $('<p>');
            $('<span>',{class:'label'}).text('Armour Tech: ').appendTo($row);
            $('<span>',{class:'value'}).text(data.tech_armour).appendTo($row);
            $container.append($row);

            $row = $('<p>');
            $('<span>',{class:'label'}).text('Propulsion Tech: ').appendTo($row);
            $('<span>',{class:'value'}).text(data.tech_propulsion).appendTo($row);
            $container.append($row);

            $row = $('<p>');
            $('<span>',{class:'label'}).text('Weapons Tech: ').appendTo($row);
            $('<span>',{class:'value'}).text(data.tech_weapons).appendTo($row);
            $container.append($row);            

            return $container;
        },

        gameDetails: function(gameDetails) {
            var str = '';
            for (var prop in gameDetails) {
                str += '<p>';
                str += prop + ': ' + gameDetails[prop];
                str += '</p>';
            }
            return str;
        }
    };
}();
