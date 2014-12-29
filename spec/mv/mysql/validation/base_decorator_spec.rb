require 'spec_helper'

require 'mv/mysql/validation/base_decorator'

describe Mv::Mysql::Validation::BaseDecorator do
  before do
    Mv::Core::Validation::Base.send(:prepend, described_class)
  end

  describe "exclusion" do
    describe 'when :as == :check' do
      subject { Mv::Core::Validation::Exclusion.new(:table_name, :column_name, in: [1, 2], as: :check) }

      it { is_expected.to be_invalid }
    end

    describe 'when :as == :trigger' do
      subject { Mv::Core::Validation::Exclusion.new(:table_name, :column_name, in: [1, 2], as: :trigger) }

      it { is_expected.to be_valid }
    end
  end

  describe "format" do
    describe 'when :as == :check' do
      subject { Mv::Core::Validation::Format.new(:table_name, :column_name, with: :with, as: :check) }

      it { is_expected.to be_invalid }
    end

    describe 'when :as == :trigger' do
      subject { Mv::Core::Validation::Format.new(:table_name, :column_name, with: :with, as: :trigger) }

      it { is_expected.to be_valid }
    end
  end

  describe "inclusion" do
    describe "when :as == :check" do
      subject { Mv::Core::Validation::Inclusion.new(:table_name, :column_name, in: [1, 2], as: :check) }

      it { is_expected.to be_invalid }
    end

    describe "when :as == :trigger" do
      subject { Mv::Core::Validation::Inclusion.new(:table_name, :column_name, in: [1, 2], as: :trigger) }

      it { is_expected.to be_valid }
    end
  end

  describe "length" do
    describe "when :as == :check" do
      subject { Mv::Core::Validation::Length.new(:table_name, :column_name, in: [1, 2], as: :check) }

      it { is_expected.to be_invalid }
    end

    describe "when :as == :trigger" do
      subject { Mv::Core::Validation::Length.new(:table_name, :column_name, in: [1, 2], as: :trigger) }

      it { is_expected.to be_valid }
    end
  end

  describe "presence" do
    describe "when :as == :check" do
      subject { Mv::Core::Validation::Presence.new(:table_name, :column_name, as: :check) }

      it { is_expected.to be_invalid }
    end

    describe "when :as == :trigger" do
      subject { Mv::Core::Validation::Presence.new(:table_name, :column_name, as: :trigger) }

      it { is_expected.to be_valid }
    end
  end

  describe "uniqueness" do
    describe "when :as == :check" do
      subject { Mv::Core::Validation::Uniqueness.new(:table_name, :column_name, as: :check) }

      it { is_expected.to be_invalid }
    end

    describe "when :as == :trigger" do
      subject { Mv::Core::Validation::Uniqueness.new(:table_name, :column_name, as: :trigger) }

      it { is_expected.to be_valid }
    end

    describe "when :as == :index" do
      subject { Mv::Core::Validation::Uniqueness.new(:table_name, :column_name, as: :index) }

      it { is_expected.to be_valid }
    end
  end
end