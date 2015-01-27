module Mv
  module Mysql
    module Validation
      module MysqlErrorMessageRestrictions
        protected

        def default_message
          super[0, 64 - column_name.length - 1]
        end
      end
    end
  end
end