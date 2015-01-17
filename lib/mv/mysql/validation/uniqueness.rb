require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Uniqueness < Mv::Core::Validation::Uniqueness
        include MysqlErrorMessageRestrictions
      end
    end
  end
end