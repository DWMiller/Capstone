dmf.templates.userDetails = function(data) {
    var $container = $('<div>');

    var $row = $('<p>').addClass('input-group');
    $('<span>', {
        class: 'label'
    }).text("Currency").appendTo($row);
    $('<span>', {
        class: 'value'
    }).text(dmf.Helpers.commafy(data.resources)).appendTo($row);
    $('<span>', {
        class: 'label'
    }).text("Research Points").appendTo($row);
    $('<span>', {
        class: 'value'
    }).text(dmf.Helpers.commafy(data.knowledge)).appendTo($row);

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
    }).text('Cost: ' + dmf.Helpers.commafy(data.tech_armour_cost)).appendTo($row);

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
    }).text('Cost: ' + dmf.Helpers.commafy(data.tech_propulsion_cost)).appendTo($row);

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
    }).text('Cost: ' + dmf.Helpers.commafy(data.tech_weapons_cost)).appendTo($row);

    $container.append($row);

    return $container;
}
