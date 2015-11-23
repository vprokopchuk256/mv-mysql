require 'spec_helper'

require 'mv/mysql/validation/builder/trigger/format'

describe Mv::Mysql::Validation::Builder::Trigger::Format do
  def format(opts = {})
    Mv::Mysql::Validation::Format.new(:table_name,
                                        :column_name,
                                        { with: /exp/, message: 'is not valid' }.merge(opts))
  end

  describe "#conditions" do
    subject { described_class.new(format(opts)).conditions }

    describe "when regex passed" do
      let(:opts) { { with: /exp/ } }

      it { is_expected.to eq([{
        statement: "NEW.column_name IS NOT NULL AND NEW.column_name RLIKE 'exp'",
        message: 'column_name is not valid'
      }]) }
    end
  end
end
