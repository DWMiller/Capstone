CORE.templates.system = function(data) {
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
}
