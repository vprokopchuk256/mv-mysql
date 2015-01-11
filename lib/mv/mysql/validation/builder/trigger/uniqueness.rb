require 'mv/mysql/validation/builder/trigger/trigger_column'

module Mv
  module Mysql
    module Validation
      module Builder
        module Trigger
          class Uniqueness < Mv::Core::Validation::Builder::Uniqueness
            include TriggerColumn 
          end
        end
      end
    end
  end
end