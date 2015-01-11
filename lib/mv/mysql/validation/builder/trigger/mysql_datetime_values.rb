module Mv
  module Mysql
    module Validation
      module Builder
        module Trigger
          module MysqlDatetimeValues
            protected
            
            def db_value value
              return "TIMESTAMP('#{value.strftime('%Y-%m-%d %H:%M:%S')}')" if value.is_a?(DateTime)
              return "TIME('#{value.strftime('%Y-%m-%d %H:%M:%S')}')" if value.is_a?(Time)
              return "DATE('#{value.strftime('%Y-%m-%d')}')" if value.is_a?(Date)
              super
            end
          end
        end
      end
    end
  end
end