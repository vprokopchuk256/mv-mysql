require 'mv/mysql/validation/builder/trigger/trigger_column'

module Mv
  module Mysql
    module Validation
      module Builder
        module Trigger
          class Length < Mv::Core::Validation::Builder::Length
            include TriggerColumn
          end
        end
      end
    end
  end
end