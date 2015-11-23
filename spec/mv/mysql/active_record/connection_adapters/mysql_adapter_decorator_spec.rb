require 'spec_helper'

require 'mv/mysql/active_record/connection_adapters/mysql_adapter_decorator'

describe Mv::Mysql::ActiveRecord::ConnectionAdapters::MysqlAdapterDecorator do
  before do
    ::ActiveRecord::Base.connection.class.send(:prepend, described_class)
  end

  let(:conn) { ::ActiveRecord::Base.connection }

  describe '#support_signal?' do
    subject { conn.support_signal? }

    context 'given server is older than 5.5' do
      before { allow(conn).to receive(:full_version).and_return('5.4') }

      it { is_expected.to be_falsey }
    end

    context 'given server is 5.5' do
      before { allow(conn).to receive(:full_version).and_return('5.5') }

      it { is_expected.to be_truthy }
    end

    context 'given server is newer than 5.5' do
      before { allow(conn).to receive(:full_version).and_return('5.6') }

      it { is_expected.to be_truthy }
    end

    context 'given some strange thing happened and full_version is not supported amymore' do
      before do
        allow(conn).to receive(:respond_to?).with(:full_version, true).and_return(false)
        expect(conn).not_to receive(:full_version)
      end

      it { is_expected.to be_falsey }
    end
  end
end
