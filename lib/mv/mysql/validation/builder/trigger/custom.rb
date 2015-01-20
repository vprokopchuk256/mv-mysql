require 'mv/mysql/validation/builder/trigger/trigger_column'

module Mv
  module Mysql
    module Validation
      module Builder
        module Trigger
          class Custom < Mv::Core::Validation::Builder::Custom
            include TriggerColumn 
          end
        end
      end
    end
  end
end