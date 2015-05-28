module Mv
  module Mysql
    class Railtie < ::Rails::Railtie
      initializer 'mv-mysql.initialization', after: 'active_record.initialize_database' do
        if defined?(::ActiveRecord::ConnectionAdapters::Mysql2Adapter) &&
           ::ActiveRecord::Base.connection.is_a?(::ActiveRecord::ConnectionAdapters::Mysql2Adapter)
          require 'mv/mysql/loader'
        end
      end
    end
  end
end
