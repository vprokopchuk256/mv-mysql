require 'spec_helper'

require 'mv/mysql/constraint/builder/trigger'

describe Mv::Mysql::Constraint::Builder::Trigger do
  before do
    Mv::Core::Services::CreateMigrationValidatorsTable.new.execute
    Mv::Core::Db::MigrationValidator.delete_all

    ::ActiveRecord::Base.connection.drop_table(:table_name) if ::ActiveRecord::Base.connection.data_source_exists?(:table_name)
    ::ActiveRecord::Base.connection.create_table(:table_name) do |t|
      t.integer :column_name
    end
  end

  describe "#validation_builders" do
    let(:trigger_description) { Mv::Core::Constraint::Description.new(:trg_mv_table_name, :trigger) }
    let(:trigger_constraint) { Mv::Core::Constraint::Trigger.new(trigger_description) }

    subject(:trigger_builder) { described_class.new(trigger_constraint) }

    subject { trigger_builder.validation_builders }

    before do
      trigger_constraint.validations << validation
    end

    describe "when exlusion validation provided" do
      let(:validation) {
        Mv::Mysql::Validation::Exclusion.new(:table_name,
                                                 :column_name,
                                                 in: [1, 3],
                                                 as: :trigger,
                                                 update_trigger_name: :trg_mv_table_name)
      }

      its(:first) { is_expected.to be_a_kind_of(Mv::Mysql::Validation::Builder::Trigger::Exclusion) }
    end

    describe "when inclusion validation provided" do
      let(:validation) {
        Mv::Mysql::Validation::Inclusion.new(:table_name,
                                                 :column_name,
                                                 in: [1, 3],
                                                 as: :trigger,
                                                 update_trigger_name: :trg_mv_table_name)
      }

      its(:first) { is_expected.to be_a_kind_of(Mv::Mysql::Validation::Builder::Trigger::Inclusion) }
    end

    describe "when length validation provided" do
      let(:validation) {
        Mv::Mysql::Validation::Length.new(:table_name,
                                                 :column_name,
                                                 in: [1, 3],
                                                 as: :trigger,
                                                 update_trigger_name: :trg_mv_table_name)
      }

      its(:first) { is_expected.to be_a_kind_of(Mv::Mysql::Validation::Builder::Trigger::Length) }
    end

    describe "when presence validation provided" do
      let(:validation) {
        Mv::Mysql::Validation::Presence.new(:table_name,
                                                 :column_name,
                                                 as: :trigger,
                                                 update_trigger_name: :trg_mv_table_name)
      }

      its(:first) { is_expected.to be_a_kind_of(Mv::Mysql::Validation::Builder::Trigger::Presence) }
    end

    describe "when absence validation provided" do
      let(:validation) {
        Mv::Mysql::Validation::Absence.new(:table_name,
                                         :column_name,
                                         as: :trigger,
                                         update_trigger_name: :trg_mv_table_name)
      }

      its(:first) { is_expected.to be_a_kind_of(Mv::Mysql::Validation::Builder::Trigger::Absence) }
    end

    describe "when custom validation provided" do
      let(:validation) {
        Mv::Mysql::Validation::Custom.new(:table_name,
                                         :column_name,
                                         as: :trigger,
                                         update_trigger_name: :trg_mv_table_name)
      }

      its(:first) { is_expected.to be_a_kind_of(Mv::Mysql::Validation::Builder::Trigger::Custom) }
    end

    describe "when uniqueness validation provided" do
      let(:validation) {
        Mv::Mysql::Validation::Uniqueness.new(:table_name,
                                             :column_name,
                                             as: :trigger,
                                             update_trigger_name: :trg_mv_table_name)
      }

      its(:first) { is_expected.to be_a_kind_of(Mv::Mysql::Validation::Builder::Trigger::Uniqueness) }
    end
  end

  describe "SQL methods" do
    let(:test_validation_builder_klass) do
      Class.new(Mv::Mysql::Validation::Builder::Trigger::Presence) do
        def conditions
          [{ statement: '1 = 1', message: 'some error message' }]
        end
      end
    end

    def triggers name
      ActiveRecord::Base.connection.select_values("
        SELECT trigger_name
          FROM information_schema.triggers
         WHERE trigger_schema='#{ActiveRecord::Base.connection.current_database}'
           AND trigger_name = '#{name}'
      ")
    end

    before do
      Mv::Mysql::Constraint::Builder::Trigger.validation_builders_factory.register_builder(
        Mv::Core::Validation::Presence,
        test_validation_builder_klass
      )
    end

    after do
      Mv::Mysql::Constraint::Builder::Trigger.validation_builders_factory.register_builder(
        Mv::Core::Validation::Presence,
        Mv::Mysql::Validation::Builder::Trigger::Presence
      )
    end

    let(:validation) {
      Mv::Core::Validation::Presence.new(:table_name,
                                        :column_name,
                                         as: :trigger,
                                         update_trigger_name: :trg_mv_table_name_upd,
                                         create_trigger_name: :trg_mv_table_name_ins)
    }


    let(:create_trigger_description) { Mv::Core::Constraint::Description.new(:trg_mv_table_name_ins, :trigger, event: :create) }
    let(:update_trigger_description) { Mv::Core::Constraint::Description.new(:trg_mv_table_name_upd, :trigger, event: :update) }

    let(:create_trigger) { Mv::Core::Constraint::Trigger.new(create_trigger_description)}
    let(:update_trigger) { Mv::Core::Constraint::Trigger.new(update_trigger_description)}

    before do
      create_trigger.validations << validation
      update_trigger.validations << validation
      ActiveRecord::Base.connection.execute('DROP TRIGGER IF EXISTS trg_mv_table_name_ins')
    end

    let(:create_trigger_builder) { Mv::Mysql::Constraint::Builder::Trigger.new(create_trigger)}
    let(:update_trigger_builder) { Mv::Mysql::Constraint::Builder::Trigger.new(update_trigger)}

    describe "#create" do
      subject { create_trigger_builder.create }

      describe "when trigger does not  exist" do
        it "creates new trigger" do
          expect { subject }.to change{ triggers('trg_mv_table_name_ins').length }.from(0).to(1)
        end
      end

      describe "when trigger already exist" do
        it "does not raise an error" do
          expect { subject }.not_to raise_error
        end
      end

      describe "when several validations provided" do
        before do
          create_trigger.validations << validation
        end

        it "does not raise an error" do
          expect{ subject }.not_to raise_error
        end
      end
    end

    describe "#update" do
      subject { create_trigger_builder.update(create_trigger_builder) }

      describe "when trigger exists" do
        before do
          ActiveRecord::Base.connection.execute(
            "CREATE TRIGGER trg_mv_table_name_ins BEFORE INSERT ON table_name FOR EACH ROW
            BEGIN
              DECLARE var INT;

              IF NOT(1 = 1) THEN
                SET var = (SELECT MAX(1) FROM `some error message`);
              END IF;
            END;"
          )
        end

        it "does not raise an error" do
          expect { subject }.not_to raise_error
        end
      end

      describe "when trigger does not exist" do
        it "creates trigger" do
          expect { subject }.to change{ triggers('trg_mv_table_name_ins').length }.from(0).to(1)
        end
      end
    end

    describe "#delete" do
      subject { create_trigger_builder.delete }

      describe "when trigger exists" do
        before do
          ActiveRecord::Base.connection.execute(
            "CREATE TRIGGER trg_mv_table_name_ins BEFORE INSERT ON table_name FOR EACH ROW
            BEGIN
              DECLARE var INT;

              IF NOT(1 = 1) THEN
                SET var = (SELECT MAX(1) FROM `some error message`);
              END IF;
            END;"
          )
        end

        it "deletes trigger" do
          expect { subject }.to change{ triggers('trg_mv_table_name_ins').length }.from(1).to(0)
        end
      end

      describe "when trigger does not exist" do
        it "does not raise an error" do
          expect { subject }.not_to raise_error
        end
      end
    end
  end
end
