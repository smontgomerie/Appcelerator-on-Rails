require "rubygems"
require "active_support"
require "active_support/core_ext/string/inflections"
require "#{File.dirname(__FILE__)}/model.rb"
require "#{File.dirname(__FILE__)}/controller.rb"
require "#{File.dirname(__FILE__)}/migration.rb"


["model", "controller", "migration"].each do |file|
  if ( ARGV[0] == file )

    # Instantiate the generator
    clazz = file.camelcase.constantize

    # Pass the rest of the arguments as parameters
    clazz.new.generate(ARGV[1..ARGV.length])
  end
end