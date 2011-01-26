require "rubygems"
require "active_support"
require "active_support/core_ext/string/inflections"
require "#{File.dirname(__FILE__)}/appcel_generator"

class Migration < AppcelGenerator
  def generate(args)
    migration = Time.now.strftime("%Y%m%d%H%M%S")

    if ( args[0] =~/^create(\w+)/i )
      model = $1.tableize

      fields_clauses = [""]
      args[1..args.length].each do |arg|
        name, type = arg.split(":")

        fields_clauses << "#{name} #{type.upcase}"
      end

      fields_sql = fields_clauses.join(",")

      text = <<text
migrate("#{migration}", "CREATE TABLE IF NOT EXISTS #{model} (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT #{fields_sql})");
text

      write_file("Resources/db/migrations/#{migration}.js", text);
    end
  end
end

if ( $0 == __FILE__ )
  puts "Do not call this file directly - use generate.rb instead"
end