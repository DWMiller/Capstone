CORE.Templates = function() {
    'use strict';

    return {
        location: function(data) {
            var structureCount = data.mines * 1 + data.shipyards * 1 + data.labs * 1;

            var owned = (data.owner_id === CORE.data.user.id);
            var $container = $('<div>');

            if (owned) {
                $container.addClass('owned');
            }

            var $row = $('<p>');
            $('<span>', {
                class: 'label'
            }).text('Type:').appendTo($row);
            $('<span>', {
                class: 'value'
            }).text(CORE.data.language.map[data.type]).appendTo($row);
            $container.append($row);

            // $row = $('<p>');
            // $('<span>',{class:'label'}).text(CORE.data.language.name).appendTo($row);
            // $('<span>',{class:'value'}).text(data.name).appendTo($row);
            // $container.append($row);

            // $row = $('<p>');
            // $('<span>', {
            //     class: 'label'
            // }).text("Position:").appendTo($row);
            // $('<span>', {
            //     class: 'value'
            // }).text("( " + data.position_x + ", " + data.position_y + " )").appendTo($row);
            // $container.append($row);

            $row = $('<p>');
            $('<span>', {
                class: 'label'
            }).text("Resources:").appendTo($row);
            $('<span>', {
                class: 'value'
            }).text(data.resources).appendTo($row);
            $container.append($row);

            $row = $('<p>');
            $('<span>', {
                class: 'label'
            }).text("Size:").appendTo($row);
            $('<span>', {
                class: 'value'
            }).text(data.size).appendTo($row);
            $container.append($row);

            $('<hr>').appendTo($container);

            // $row = $('<p>');
            // $('<span>',{class:'label'}).text("Owner:").appendTo($row);
            // $('<span>',{class:'value'}).text(data.owner_id||'Unclaimed').appendTo($row);
            // $container.append($row);                                    

            // $row = $('<p>');
            // $('<span>',{class:'label'}).text(CORE.data.language.structure.mines+": ").appendTo($row);
            // $('<span>',{class:'value'}).text(data.mines).appendTo($row);
            // if(owned && data.resources > 0) {
            //     $('<button>',{class:'upgrade-structure', 'data-structure': 'mine'}).text('Upgrade - ' + data['upgrade-cost-mine']).appendTo($row);
            // }

            $('<h3>').text('Planet Infrastructure').appendTo($container);

            $row = $('<p>', {
                class: 'upgrade-btn structure-mine',
                'data-structure': 'mine',
                title: CORE.data.language.structure.mines
            });
            $('<span>', {
                class: 'level'
            }).text(data.mines).appendTo($row);

            if (owned && data.resources > 0) {
                $('<span>', {
                    class: 'cost'
                }).text('Cost: ' + CORE.Helpers.commafy(data['upgrade-cost-mine'])).appendTo($row);
            }

            $container.append($row);

            $row = $('<p>', {
                class: 'upgrade-btn structure-shipyard',
                'data-structure': 'shipyard',
                title: CORE.data.language.structure.shipyards
            });
            $('<span>', {
                class: 'level'
            }).text(data.shipyards).appendTo($row);
            if (owned && data.resources > 0) {
                $('<span>', {
                    class: 'cost'
                }).text('Cost: ' + CORE.Helpers.commafy(data['upgrade-cost-shipyard'])).appendTo($row);
            }

            $container.append($row);

            $row = $('<p>', {
                class: 'upgrade-btn structure-lab',
                'data-structure': 'lab',
                title: CORE.data.language.structure.labs
            });
            $('<span>', {
                class: 'level'
            }).text(data.labs).appendTo($row);
            if (owned && data.resources > 0) {
                $('<span>', {
                    class: 'cost'
                }).text('Cost: ' + CORE.Helpers.commafy(data['upgrade-cost-lab'])).appendTo($row);
            }

            $container.append($row);


            if (owned) {
                $row = $('<p>');
                $('<input>', {
                    type: 'text',
                    value: data.name
                }).appendTo($row);
                $('<button>', {
                    class: 'location-rename'
                }).text('Rename').appendTo($row);
                $container.append($row);
            }

            return $container;
        },

        system: function(data) {
            var $container = $('<div>');

            var $row = $('<p>');
            $('<span>', {
                class: 'label'
            }).text("Type:").appendTo($row);
            $('<span>', {
                class: 'value'
            }).text(CORE.data.language.map[data.type]).appendTo($row);
            $container.append($row);

            // $row = $('<p>');
            // $('<span>',{class:'label'}).text(CORE.data.language.name).appendTo($row);
            // $('<span>',{class:'value'}).text(data.name).appendTo($row);
            // $container.append($row);

            // $row = $('<p>');
            // $('<span>', {
            //     class: 'label'
            // }).text("Position:").appendTo($row);
            // $('<span>', {
            //     class: 'value'
            // }).text("( " + data.position_x + ", " + data.position_y + " )").appendTo($row);
            // $container.append($row);

            $row = $('<p>');
            $('<span>', {
                class: 'label'
            }).text("Size:").appendTo($row);
            $('<span>', {
                class: 'value'
            }).text(data.size).appendTo($row);
            $container.append($row);

            $('<hr>').appendTo($container);
            return $container;
        },

        userDetails: function(data) {
            var $container = $('<div>');

            var $row = $('<p>').addClass('input-group');
            $('<span>', {
                class: 'label'
            }).text("Currency").appendTo($row);
            $('<span>', {
                class: 'value'
            }).text(CORE.Helpers.commafy(data.resources)).appendTo($row);
            $('<span>', {
                class: 'label'
            }).text("Research Points").appendTo($row);
            $('<span>', {
                class: 'value'
            }).text(CORE.Helpers.commafy(data.knowledge)).appendTo($row);

            $container.append($row);

            // Add icon/button for upgrading armour tech

            $row = $('<p>', {
                class: 'upgrade-btn research-start research-armour',
                'data-research': 'armour',
                'title': 'Armour research - reduces ship losses in combat '
            });
            $('<span>', {
                class: 'level'
            }).text(data.tech_armour).appendTo($row);
            $('<span>', {
                class: 'cost'
            }).text('Cost: ' + CORE.Helpers.commafy(data.tech_armour_cost)).appendTo($row);

            $container.append($row);
            
            // Add icon/button for upgrading propulsion tech

            $row = $('<p>', {
                class: 'upgrade-btn research-start research-propulsion',
                'data-research': 'propulsion',
                'title': 'Propulsion research - increases fleet movement speed '
            });
            $('<span>', {
                class: 'level'
            }).text(data.tech_propulsion).appendTo($row);
            $('<span>', {
                class: 'cost'
            }).text('Cost: ' + CORE.Helpers.commafy(data.tech_propulsion_cost)).appendTo($row);

            $container.append($row);


            // Add icon/button for upgrading weapons tech

            $row = $('<p>', {
                class: 'upgrade-btn research-start research-weapons',
                'data-research': 'weapons',
                'title': 'Weapons research - kill more ships in combat '
            });
            $('<span>', {
                class: 'level'
            }).text(data.tech_weapons).appendTo($row);
            $('<span>', {
                class: 'cost'
            }).text('Cost: ' + CORE.Helpers.commafy(data.tech_weapons_cost)).appendTo($row);

            $container.append($row);

            return $container;
        },

        // gameDetails: function(gameDetails) {
        //     var str = '';
        //     for (var prop in gameDetails) {
        //         str += '<p>';
        //         str += prop + ': ' + gameDetails[prop];
        //         str += '</p>';
        //     }
        //     return str;
        // }
    };
}();
