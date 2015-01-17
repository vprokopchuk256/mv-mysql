require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Length < Mv::Core::Validation::Length
        include MysqlErrorMessageRestrictions
      end
    end
  end
end