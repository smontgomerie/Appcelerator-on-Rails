Ti.include("../include/inheritance.js");
Ti.include("../include/db.js");
Ti.include("../common/controller.js");
Ti.include("../views/main.js");

var MainController = Controller.extend({
    init: function(win) {
        this._super(win);

        this.view = new MainView(win, this);
    }
});

(function() {
    var win = Titanium.UI.currentWindow;

    new MainController(win);
})();

