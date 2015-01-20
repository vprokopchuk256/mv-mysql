require 'spec_helper'

require 'mv/mysql/validation/custom'

describe Mv::Mysql::Validation::Custom do
  let(:validation) { described_class.new('long_table_name' * 5, :column_name, statement: '{column_name> > 1') }

  describe "#message" do
    subject { validation.message }

    its(:length) { is_expected.to be <= 64 }
  end
end