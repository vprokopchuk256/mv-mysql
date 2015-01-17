$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'mv-test'
require 'rspec/its'
require 'mv-mysql'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

ActiveRecord::Migration.verbose = false

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.before :each do
    ActiveRecord::Base.remove_connection if ::ActiveRecord::Base.connected?
    ActiveRecord::Base.establish_connection(adapter: "mysql2", 
                                            database: "validation_migration_test_db", 
                                            username: "root")
  end   
end
