require "rubygems"
require "active_support"
require "active_support/core_ext/string/inflections"
require "#{File.dirname(__FILE__)}/appcel_generator"
require "#{File.dirname(__FILE__)}/migration"

class Model < AppcelGenerator
  def field_type(type)
    case type
      when /String/i, /Boolean/i
        return type.capitalize
      when /integer/i
        return "Number"
      else
        raise "Unknown type '#{type}'"
    end
  end

  def generate(args)
    model = args[0].camelize
    table = args[0].tableize

    fields_clauses = [""]
    args[1..args.length].each do |arg|
        name, type = arg.split(":")

        fields_clauses << "#{name} : #{field_type(type)}"
    end

    fields_sql = fields_clauses.join(",")

    text  = <<test

var #{model} = Model.extend({
    table_name: "#{table}",
    _fields: {id: Number #{fields_sql}},

    find: function(id) {
        var model = new #{model}(this.db, this._find(id));
        return model;
    },

    item_from: function(row) {
        var model = new #{model}(this.db, this._item_from(row));
        return model;
    }
});
test

    write_file("Resources/models/#{model.tableize}.js", text)

    Migration.new.generate(["Create#{model}"] + args[1..args.length])
  end
end

if ($0 == __FILE__)
  puts "Do not call this file directly - use generate.rb instead"
end