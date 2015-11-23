require 'spec_helper'

require 'mv/mysql/validation/builder/trigger/custom'

describe Mv::Mysql::Validation::Builder::Trigger::Custom do
  def custom(opts = {})
    Mv::Core::Validation::Custom.new(:table_name,
                                       :column_name,
                                        { message: 'must be valid' }.merge(opts))
  end

  describe "#conditions" do
    subject { described_class.new(custom(opts)).conditions }

    describe "by default" do
      let(:opts) { { statement: '{column_name} > 1'} }

      it { is_expected.to eq([{
        statement: "NEW.column_name IS NOT NULL AND (NEW.column_name > 1)",
        message: 'column_name must be valid'
      }]) }
    end
  end
end
