require 'spec_helper'

require 'mv/mysql/validation/length'

describe Mv::Mysql::Validation::Length do
  let(:validation) { described_class.new('long_table_name' * 5, :column_name, in: [1, 5]) }

  describe "#message" do
    subject { validation.message }

    its(:length) { is_expected.to be <= 64 }
  end
end