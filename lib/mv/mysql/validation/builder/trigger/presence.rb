require 'mv/mysql/validation/builder/trigger/trigger_column'

module Mv
  module Mysql
    module Validation
      module Builder
        module Trigger
          class Presence < Mv::Core::Validation::Builder::Presence
            include TriggerColumn 
          end
        end
      end
    end
  end
end