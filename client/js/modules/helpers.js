
CORE.Helpers = function() {
    'use strict';
    return {
        commafy: function(num) {
            if(!num) {
                return '0';
            }

            //http://snipplr.com/view/66256/format-numbers-in-javascript-with-group-digits/
            return num.toString().split( /(?=(?:\d{3})+(?:\.|$))/g ).join( "," );
        },
    };
}();
