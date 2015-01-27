require 'spec_helper'

require 'mv/mysql/validation/builder/trigger/length'

describe Mv::Mysql::Validation::Builder::Trigger::Length do
  def length(opts = {})
    Mv::Core::Validation::Length.new(:table_name, 
                                    :column_name,
                                    { with: /exp/, message: 'has invalid length' }.merge(opts)) 
  end

  describe "#conditions" do
    subject { described_class.new(length(opts)).conditions }

    describe "when :in is defined" do
      describe "as array" do
        let(:opts) { { in: [1, 3] } }

        it { is_expected.to eq([{
          statement: 'NEW.column_name IS NOT NULL AND LENGTH(NEW.column_name) IN (1, 3)', 
          message: 'ColumnName has invalid length'
        }]) }
      end
    end
  end
end