Ti.include("../include/inheritance.js");

var View = Class.extend({
    init: function(win, controller)
    {
        this.win = win;
        this.controller = controller;

        win.viewClass = this;
    }
});
