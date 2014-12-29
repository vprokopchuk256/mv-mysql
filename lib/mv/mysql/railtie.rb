require 'mv/mysql/active_record/connection_adapters/mysql_adapter_decorator'

module Mv
  module Mysql
    class Railtie < ::Rails::Railtie
      initializer 'mv-mysql.initialization', after: 'active_record.initialize_database' do
        ::ActiveRecord::ConnectionAdapters::Mysql2Adapter.send(:prepend, Mv::Mysql::ActiveRecord::ConnectionAdapters::MysqlAdapterDecorator)
      end
    end
  end
end