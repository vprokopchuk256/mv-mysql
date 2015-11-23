require 'spec_helper'

require 'mv/mysql/validation/builder/trigger/absence'

describe Mv::Mysql::Validation::Builder::Trigger::Absence do
  def absence(opts = {})
    Mv::Core::Validation::Absence.new(:table_name,
                                       :column_name,
                                        { message: 'must be empty' }.merge(opts))
  end

  describe "#conditions" do
    subject { described_class.new(absence(opts)).conditions }

    describe "by default" do
      let(:opts) { {} }

      it { is_expected.to eq([{
        statement: "NEW.column_name IS NULL OR LENGTH(TRIM(NEW.column_name)) = 0",
        message: 'column_name must be empty'
      }]) }
    end
  end
end
