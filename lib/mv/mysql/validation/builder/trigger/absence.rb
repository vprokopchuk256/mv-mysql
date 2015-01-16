require 'mv/mysql/validation/builder/trigger/trigger_column'

module Mv
  module Mysql
    module Validation
      module Builder
        module Trigger
          class Absence < Mv::Core::Validation::Builder::Absence
            include TriggerColumn 
          end
        end
      end
    end
  end
end