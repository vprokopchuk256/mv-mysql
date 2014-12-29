require 'mv-core'
require 'mv/mysql/validation/base_decorator'
require 'mv/mysql/railtie'

ActiveSupport.on_load(:mv_core) do
  Mv::Core::Validation::Base.send(:prepend, Mv::Mysql::Validation::BaseDecorator)
end

