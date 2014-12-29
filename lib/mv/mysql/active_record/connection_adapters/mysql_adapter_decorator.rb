module Mv
  module Mysql
    module ActiveRecord
      module ConnectionAdapters
        module MysqlAdapterDecorator
          include Mv::Core::ActiveRecord::ConnectionAdapters::AbstractAdapterDecorator
        end
      end
    end
  end
end