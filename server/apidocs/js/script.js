function getAndInsert(path, container) {
    var r = new XMLHttpRequest();
    r.open("POST", path, true);
    r.onreadystatechange = function() {
        if (r.readyState != 4 || r.status != 200) return;
        container.innerHTML = r.responseText;
    };
    r.send();
}


var apiList = document.getElementById('api-list');

getAndInsert('includes/api_list.html', apiList);


