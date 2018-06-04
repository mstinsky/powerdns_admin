override_facts = {
  root_home: '/root',
}

require 'spec_helper'
describe 'powerdns_admin', type: :class do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(override_facts)
        end

        context 'powerdns_admin class with parameters' do
          let(:params) do
            {
              db_root_password: 'foobar',
              db_password: 'foo',
              pdns_api_key: 'bar',
            }
          end

          it { is_expected.to compile.with_all_deps }
        end
      end
    end
  end
end
