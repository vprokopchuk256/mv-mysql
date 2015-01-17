require 'spec_helper'

require 'mv/mysql/validation/absence'

describe Mv::Mysql::Validation::Absence do
  let(:validation) { described_class.new('long_table_name' * 5, :column_name, {}) }

  describe "#message" do
    subject { validation.message }

    its(:length) { is_expected.to be <= 64 }
  end
end