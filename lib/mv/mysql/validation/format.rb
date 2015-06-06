require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Format < Mv::Core::Validation::Format
        include MysqlErrorMessageRestrictions
      end
    end
  end
end
