require 'mv/mysql/validation/builder/format'
require 'mv/mysql/validation/builder/trigger/trigger_column'

module Mv
  module Mysql
    module Validation
      module Builder
        module Trigger
          class Format < Mv::Mysql::Validation::Builder::Format
            include TriggerColumn
          end
        end
      end
    end
  end
end
