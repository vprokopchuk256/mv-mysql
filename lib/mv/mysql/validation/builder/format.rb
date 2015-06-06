module Mv
  module Mysql
    module Validation
      module Builder
        class Format < Mv::Core::Validation::Builder::Format
          protected

          def apply_with stmt
            "#{stmt} RLIKE #{db_value(with)}"
          end
        end
      end
    end
  end
end
