
var exec = require('cordova/exec');

module.exports = {
    init:function(win,lose){// todo: callbacks
        function onSuccess(res) {
            win && win(res);
        }
               
        function onError(err) {
            lose && lose(err);
        }
        exec(onSuccess, onError, "PGiAdPlugin", "init", []);
    }

}
