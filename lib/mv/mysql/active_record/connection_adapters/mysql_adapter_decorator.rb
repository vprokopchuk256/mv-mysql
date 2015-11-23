module Mv
  module Mysql
    module ActiveRecord
      module ConnectionAdapters
        module MysqlAdapterDecorator
          include Mv::Core::ActiveRecord::ConnectionAdapters::AbstractAdapterDecorator

          def support_signal?
            respond_to?(:full_version, true) && full_version >= '5.5'
          end
        end
      end
    end
  end
end
