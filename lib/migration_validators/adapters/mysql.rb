# module MigrationValidators
#   module Adapters
#     class Mysql < MigrationValidators::Adapters::Base
#       def name
#         "Mysql Migration Validators Adapter"
#       end

#       define_base_syntax
#       define_base_validators
#       define_base_containers

#       container :insert_trigger do
#         operation :create do |stmt, trigger_name, group_name|
#           "CREATE TRIGGER #{trigger_name} BEFORE INSERT ON #{group_name.first} FOR EACH ROW
#            BEGIN
#             DECLARE var INT;

#             #{stmt};
#            END;"
#         end

#         operation :db_value do |value|
#           case value.class.name
#             when "String" then "'#{value}'"
#             when "Date" then "DATE('#{value.strftime('%Y-%m-%d')}')"
#             when "DateTime" then "TIMESTAMP('#{value.strftime('%Y-%m-%d %H:%M:%S')}')"
#             when "Time" then "TIME('#{value.strftime('%Y-%m-%d %H:%M:%S')}')"
#             when "Regexp" then "'#{value.source}'"
#             else value.to_s
#           end
#         end

#         operation :bind_to_error do |stmt, error_message|
#           "IF NOT(#{stmt}) THEN
#             SET var = (SELECT MAX(1) FROM `#{error_message}`);
#            END IF"
#         end
#       end

#       container :update_trigger do
#         operation :create do |stmt, trigger_name, group_name|
#           "CREATE TRIGGER #{trigger_name} BEFORE UPDATE ON #{group_name.first} FOR EACH ROW
#            BEGIN
#             DECLARE var INT;

#             #{stmt};
#            END;"
#         end

#         operation :db_value do |value|
#           case value.class.name
#             when "String" then "'#{value}'"
#             when "Date" then "DATE('#{value.strftime('%Y-%m-%d')}')"
#             when "DateTime" then "TIMESTAMP('#{value.strftime('%Y-%m-%d %H:%M:%S')}')"
#             when "Time" then "TIME('#{value.strftime('%Y-%m-%d %H:%M:%S')}')"
#             when "Regexp" then "'#{value.source}'"
#             else value.to_s
#           end
#         end

#         operation :bind_to_error do |stmt, error_message|
#           "IF NOT(#{stmt}) THEN
#             SET var = (SELECT MAX(1) FROM `#{error_message}`);
#            END IF"
#         end
#       end


#       route :presence, :trigger, :default => true do
#         to :insert_trigger, :if => {:on => [:save, :create, nil]}
#         to :update_trigger, :if => {:on => [:save, :update, nil]}
#       end

#       route :inclusion, :trigger, :default => true do
#         to :insert_trigger, :if => {:on => [:save, :create, nil]}
#         to :update_trigger, :if => {:on => [:save, :update, nil]}
#       end

#       route :exclusion, :trigger, :default => true do
#         to :insert_trigger, :if => {:on => [:save, :create, nil]}
#         to :update_trigger, :if => {:on => [:save, :update, nil]}
#       end

#       route :length, :trigger, :default => true do
#         to :insert_trigger, :if => {:on => [:save, :create, nil]}
#         to :update_trigger, :if => {:on => [:save, :update, nil]}
#       end

#       route :format, :trigger, :default => true do
#         to :insert_trigger, :if => {:on => [:save, :create, nil]}
#         to :update_trigger, :if => {:on => [:save, :update, nil]}
#       end

#       route :uniqueness, :trigger do
#         to :insert_trigger, :if => {:on => [:save, :create, nil]}
#         to :update_trigger, :if => {:on => [:save, :update, nil]}
#       end
#     end

#     MigrationValidators.register_adapter! "mysql", Mysql
#     MigrationValidators.register_adapter! "mysql2", Mysql
#   end
# end
