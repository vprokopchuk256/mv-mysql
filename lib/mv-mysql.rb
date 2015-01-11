require 'mv-core'
require 'mv/mysql/railtie'

require 'mv/mysql/constraint/builder/trigger'

require 'mv/mysql/validation/builder/trigger/exclusion'
require 'mv/mysql/validation/builder/trigger/inclusion'
require 'mv/mysql/validation/builder/trigger/length'
require 'mv/mysql/validation/builder/trigger/presence'
require 'mv/mysql/validation/builder/trigger/uniqueness'

ActiveSupport.on_load(:mv_core) do

  #constraint builders
  Mv::Core::Constraint::Builder::Factory.register_builders(
    Mv::Core::Constraint::Trigger => Mv::Mysql::Constraint::Builder::Trigger,
  )

  #validation builders in trigger
  Mv::Mysql::Constraint::Builder::Trigger.validation_builders_factory.register_builders(
    Mv::Core::Validation::Exclusion => Mv::Mysql::Validation::Builder::Trigger::Exclusion,
    Mv::Core::Validation::Inclusion => Mv::Mysql::Validation::Builder::Trigger::Inclusion,
    Mv::Core::Validation::Length    => Mv::Mysql::Validation::Builder::Trigger::Length,
    Mv::Core::Validation::Presence  => Mv::Mysql::Validation::Builder::Trigger::Presence,
    Mv::Core::Validation::Uniqueness      => Mv::Mysql::Validation::Builder::Trigger::Uniqueness
  )
end

