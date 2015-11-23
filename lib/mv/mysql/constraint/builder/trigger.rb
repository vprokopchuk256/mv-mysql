module Mv
  module Mysql
    module Constraint
      module Builder
        class Trigger < Mv::Core::Constraint::Builder::Trigger
          def create
            validation_builders.group_by(&:table_name).each do |table_name, validations|
              db.execute(drop_trigger_statement(table_name))
              db.execute(create_trigger_statement(table_name))
            end
          end

          def delete
            validation_builders.group_by(&:table_name).each do |table_name, validations|
              db.execute(drop_trigger_statement(table_name))
            end
          end

          def update new_constraint_builder
            delete
            new_constraint_builder.create
          end

          private


          def drop_trigger_statement table_name
            "DROP TRIGGER IF EXISTS #{name};"
          end

          def create_trigger_statement table_name
            "CREATE TRIGGER #{name} BEFORE #{update? ? 'UPDATE' : 'INSERT'} ON #{table_name} FOR EACH ROW
             BEGIN
              DECLARE var INT;

              #{trigger_body(table_name)};
             END;"
          end

          def trigger_body(table_name)
            validation_builders.select{|b| b.table_name == table_name }.collect(&:conditions).flatten.collect do |condition|
              "IF NOT(#{condition[:statement]}) THEN
                #{raise_error_statement(condition[:message])}
              END IF".squish
            end.join("; \n")
          end

          def raise_error_statement message
            return "SIGNAL SQLSTATE '45000' SET message_text = '#{message}';" if db.support_signal?

            "SET var = (SELECT MAX(1) FROM `#{message}`);"
          end
        end
      end
    end
  end
end
