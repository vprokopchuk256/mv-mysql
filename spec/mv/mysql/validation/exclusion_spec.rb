require 'spec_helper'

require 'mv/mysql/validation/exclusion'

describe Mv::Mysql::Validation::Exclusion do
  let(:validation) { described_class.new('long_table_name' * 5, :column_name, in: [1, 5]) }

  describe "#message" do
    subject { validation.message }

    its(:length) { is_expected.to be <= 64 }
  end
end