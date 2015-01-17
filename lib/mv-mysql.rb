require 'mv-core'
require 'mv/mysql/railtie'

require 'mv/mysql/constraint/builder/trigger'

require 'mv/mysql/validation/exclusion'
require 'mv/mysql/validation/inclusion'
require 'mv/mysql/validation/length'
require 'mv/mysql/validation/presence'
require 'mv/mysql/validation/absence'
require 'mv/mysql/validation/uniqueness'

require 'mv/mysql/validation/builder/trigger/exclusion'
require 'mv/mysql/validation/builder/trigger/inclusion'
require 'mv/mysql/validation/builder/trigger/length'
require 'mv/mysql/validation/builder/trigger/presence'
require 'mv/mysql/validation/builder/trigger/absence'
require 'mv/mysql/validation/builder/trigger/uniqueness'

ActiveSupport.on_load(:mv_core) do

  #constraint builders
  Mv::Core::Constraint::Builder::Factory.register_builders(
    Mv::Core::Constraint::Trigger => Mv::Mysql::Constraint::Builder::Trigger,
  )

  #validations
  Mv::Core::Validation::Factory.register_validations(
    :exclusion   => Mv::Mysql::Validation::Exclusion,
    :inclusion   => Mv::Mysql::Validation::Inclusion,
    :length      => Mv::Mysql::Validation::Length,
    :presence    => Mv::Mysql::Validation::Presence,
    :absence     => Mv::Mysql::Validation::Absence,
    :uniqueness  => Mv::Mysql::Validation::Uniqueness
  )

  #validation builders in trigger
  Mv::Mysql::Constraint::Builder::Trigger.validation_builders_factory.register_builders(
    Mv::Mysql::Validation::Exclusion   => Mv::Mysql::Validation::Builder::Trigger::Exclusion      ,
    Mv::Mysql::Validation::Inclusion   => Mv::Mysql::Validation::Builder::Trigger::Inclusion,
    Mv::Mysql::Validation::Length      => Mv::Mysql::Validation::Builder::Trigger::Length,
    Mv::Mysql::Validation::Presence    => Mv::Mysql::Validation::Builder::Trigger::Presence,
    Mv::Mysql::Validation::Absence     => Mv::Mysql::Validation::Builder::Trigger::Absence,
    Mv::Mysql::Validation::Uniqueness  => Mv::Mysql::Validation::Builder::Trigger::Uniqueness
  )

  #validation builders in trigger
  Mv::Mysql::Constraint::Builder::Trigger.validation_builders_factory.register_builders(
    Mv::Core::Validation::Exclusion   => Mv::Mysql::Validation::Builder::Trigger::Exclusion,
    Mv::Core::Validation::Inclusion   => Mv::Mysql::Validation::Builder::Trigger::Inclusion,
    Mv::Core::Validation::Length      => Mv::Mysql::Validation::Builder::Trigger::Length,
    Mv::Core::Validation::Presence    => Mv::Mysql::Validation::Builder::Trigger::Presence,
    Mv::Core::Validation::Absence     => Mv::Mysql::Validation::Builder::Trigger::Absence,
    Mv::Core::Validation::Uniqueness  => Mv::Mysql::Validation::Builder::Trigger::Uniqueness
  )
end

