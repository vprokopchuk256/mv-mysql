require 'spec_helper'

describe 'Add validation scenarios' do
  before do
    Mv::Core::Services::CreateMigrationValidatorsTable.new.execute
    Mv::Core::Db::MigrationValidator.delete_all
    ::ActiveRecord::ConnectionAdapters::Mysql2Adapter.send(:prepend, Mv::Mysql::ActiveRecord::ConnectionAdapters::MysqlAdapterDecorator)

    Mv::Core::Migration::Base.with_suppressed_validations do
      ActiveRecord::Base.connection.drop_table(:table_name) if ActiveRecord::Base.connection.data_source_exists?(:table_name)
    end
  end

  subject(:migrate) { migration.migrate(:up) }

  describe 'change_table' do
    describe "create column" do
      before do
        ActiveRecord::Base.connection.create_table :table_name do |t|
          t.string :column_name
        end
      end

      let(:migration) do
        Class.new(::ActiveRecord::Migration[5.0]) do
          def change
            change_table :table_name, id: false do |t|
              t.string :column_name_1, validates: { length: { is: 5, on: :create} }
            end
          end
        end.new('TestMigration', '20141118164617')
      end


      it "adds new validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      it "creates new trigger constraint" do
        expect_any_instance_of(Mv::Mysql::Constraint::Builder::Trigger).to receive(:create).once
        subject
      end
    end

    describe "update column" do
      before do
        ActiveRecord::Base.connection.create_table :table_name do |t|
          t.string :column_name
        end
      end

      let(:migration) do
        Class.new(::ActiveRecord::Migration[5.0]) do
          def change
            change_table :table_name, id: false do |t|
              t.change :column_name, :string, validates: { length: { is: 5, on: :create} }
            end
          end
        end.new('TestMigration', '20141118164617')
      end


      it "adds new validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      it "creates new trigger constraint" do
        expect_any_instance_of(Mv::Mysql::Constraint::Builder::Trigger).to receive(:create).once
        subject
      end
    end
  end

  describe 'standalone' do
    describe "create column" do
      before do
        ActiveRecord::Base.connection.create_table :table_name do |t|
          t.string :column_name
        end
      end

      let(:migration) do
        Class.new(::ActiveRecord::Migration[5.0]) do
          def change
            add_column :table_name, :column_name_1, :string, validates: { length: { is: 5, on: :create} }
          end
        end.new('TestMigration', '20141118164617')
      end


      it "adds new validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      it "creates new trigger constraint" do
        expect_any_instance_of(Mv::Mysql::Constraint::Builder::Trigger).to receive(:create).once
        subject
      end
    end

    describe "update column" do
      before do
        ActiveRecord::Base.connection.create_table :table_name do |t|
          t.string :column_name
        end
      end

      let(:migration) do
        Class.new(::ActiveRecord::Migration[5.0]) do
          def change
            change_column :table_name, :column_name, :string, validates: { length: { is: 5, on: :create} }
          end
        end.new('TestMigration', '20141118164617')
      end


      it "adds new validator" do
        expect{ subject }.to change(Mv::Core::Db::MigrationValidator, :count).by(1)
      end

      it "creates new trigger constraint" do
        expect_any_instance_of(Mv::Mysql::Constraint::Builder::Trigger).to receive(:create).once
        subject
      end
    end
  end
end
