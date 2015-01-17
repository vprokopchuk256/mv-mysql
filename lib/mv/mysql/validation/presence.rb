require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Presence < Mv::Core::Validation::Presence
        include MysqlErrorMessageRestrictions
      end
    end
  end
end