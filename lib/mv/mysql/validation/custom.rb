require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Custom < Mv::Core::Validation::Custom
        include MysqlErrorMessageRestrictions
      end
    end
  end
end