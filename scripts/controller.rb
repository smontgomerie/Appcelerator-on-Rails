require "rubygems"
require "active_support"
require "active_support/core_ext/string/inflections"
require "#{File.dirname(__FILE__)}/appcel_generator"

class Controller < AppcelGenerator
  def generate(args)
    name = args[0].camelize

    view = <<eos
Ti.include("../include/inheritance.js");
Ti.include("../include/db.js");
Ti.include("../common/view.js");

var #{name}View = View.extend({
    init: function(win, controller) {
        this._super(win, controller);

        this.layout();
    },

    layout: function() {

    }

});
eos

    controller = <<controller
Ti.include("../include/inheritance.js");
Ti.include("../include/db.js");
Ti.include("../common/controller.js");
Ti.include("../views/#{name.tableize}.js");

var #{name}Controller = Controller.extend({
    init: function(win) {
        this._super(win);

        this.view = new #{name}View(win, this);
    }
});

(function() {
    var win = Titanium.UI.currentWindow;

    new #{name}Controller(win);
})();

controller

    write_file("Resources/controllers/#{name.tableize}.js", controller)
    write_file("Resources/views/#{name.tableize}.js", view)
  end
end

if ( $0 == __FILE__ )
  puts "Do not call this file directly - use generate.rb instead"
end