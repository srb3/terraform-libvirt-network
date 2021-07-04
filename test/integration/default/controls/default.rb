require 'tempfile'

expected_network_name = input('expected_network_name')
expected_network_address = input('expected_network_address')
expected_network_prefix = input('expected_network_prefix')
expected_dns_enabled = input('expected_dns_enabled')

temp = Tempfile.new
temp << command("virsh net-dumpxml #{expected_network_name}| xmllint -").stdout.gsub("\n", '').strip
temp.flush

describe xml(temp) do
  its('network/name') { should eq [expected_network_name] }
  its('network/dns/@enable') { should eq [expected_dns_enabled] }
  its('network/ip/@address') { should eq [expected_network_address] }
  its('network/ip/@prefix') { should eq [expected_network_prefix] }
end
