require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Exclusion < Mv::Core::Validation::Exclusion
        include MysqlErrorMessageRestrictions
      end
    end
  end
end