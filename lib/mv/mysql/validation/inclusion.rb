require 'mv/mysql/validation/mysql_error_message_restrictions'

module Mv
  module Mysql
    module Validation
      class Inclusion < Mv::Core::Validation::Inclusion
        include MysqlErrorMessageRestrictions
      end
    end
  end
end