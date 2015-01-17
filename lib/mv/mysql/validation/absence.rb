require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Absence < Mv::Core::Validation::Absence
        include MysqlErrorMessageRestrictions
      end
    end
  end
end