module Mv
  module Mysql
    module Validation
      module MysqlErrorMessageRestrictions
        protected

        def default_message
          super[0, 64]
        end
      end
    end
  end
end