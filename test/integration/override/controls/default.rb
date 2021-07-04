require 'tempfile'

expected_name = input('expected_name')
expected_mode = input('expected_mode')
expected_domain = input('expected_domain')
expected_mtu = input('expected_mtu')
expected_address = input('expected_address')
expected_prefix = input('expected_prefix')
expected_dns_enabled = input('expected_dns_enabled')
expected_dhcp_range_start = input('expected_dhcp_range_start')
expected_forwarder_domain1 = input('expected_forwarder_domain1')
expected_forwarder_addr1 = input('expected_forwarder_addr1')
expected_forwarder_domain2 = input('expected_forwarder_domain2')
expected_forwarder_addr2 = input('expected_forwarder_addr2')
expected_static_host_ip1 = input('expected_static_host_ip1')
expected_static_hostname1 = input('expected_static_hostname1')
expected_static_route_address1 = input('expected_static_route_address1')
expected_static_route_prefix1 = input('expected_static_route_prefix1')
expected_static_route_gateway1 = input('expected_static_route_gateway1')
expected_static_host_ip2 = input('expected_static_host_ip2')
expected_static_hostname2 = input('expected_static_hostname2')
expected_static_route_address2 = input('expected_static_route_address2')
expected_static_route_prefix2 = input('expected_static_route_prefix2')
expected_static_route_gateway2 = input('expected_static_route_gateway2')

temp = Tempfile.new
temp << command("virsh net-dumpxml #{expected_name}| xmllint -").stdout.gsub("\n", '').strip
temp.flush

describe xml(temp) do
  its('network/name') { should eq [expected_name] }
  its('network/forward/@mode') { should eq [expected_mode] }
  its('network/domain/@name') { should eq [expected_domain] }
  its('network/mtu/@size') { should eq [expected_mtu] }
  its('network/dns/@enable') { should eq [expected_dns_enabled] }
  its('network/ip/@address') { should eq [expected_address] }
  its('network/ip/@prefix') { should eq [expected_prefix] }
  its('network/ip/dhcp/range/@start') { should eq [expected_dhcp_range_start] }
  its('network/dns/forwarder[1]/@domain') { should eq [expected_forwarder_domain1] }
  its('network/dns/forwarder[1]/@addr') { should eq [expected_forwarder_addr1] }
  its('network/dns/forwarder[2]/@domain') { should eq [expected_forwarder_domain2] }
  its('network/dns/forwarder[2]/@addr') { should eq [expected_forwarder_addr2] }
  its('network/dns/host[1]/@ip') { should eq [expected_static_host_ip1] }
  its('network/dns/host[1]/hostname') { should eq [expected_static_hostname1] }
  its('network/route[1]/@address') { should eq [expected_static_route_address1] }
  its('network/route[1]/@prefix') { should eq [expected_static_route_prefix1] }
  its('network/route[1]/@gateway') { should eq [expected_static_route_gateway1] }
  its('network/dns/host[2]/@ip') { should eq [expected_static_host_ip2] }
  its('network/dns/host[2]/hostname') { should eq [expected_static_hostname2] }
  its('network/route[2]/@address') { should eq [expected_static_route_address2] }
  its('network/route[2]/@prefix') { should eq [expected_static_route_prefix2] }
  its('network/route[2]/@gateway') { should eq [expected_static_route_gateway2] }
end
