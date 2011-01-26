Ti.include("../include/inheritance.js");

var Controller = Class.extend({
    init: function(win)
    {
        this.win = win;
        win.controllerClass = this;
    }
});
