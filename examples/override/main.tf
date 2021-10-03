provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  forwarders = [
    {
      "address" = "8.8.8.8",
      "domain"  = ".com"
    },
    {
      "address" = "192.168.1.1",
      "domain"  = ".corp"
    }
  ]

  hosts = [
    {
      "hostname" = "ad",
      "ip"       = "192.168.1.10"
    },
    {
      "hostname" = "mon",
      "ip"       = "192.168.1.11"
    }
  ]

  routes = [
    {
      "cidr"    = "192.168.2.0/24",
      "gateway" = "192.168.11.1"
    },
    {
      "cidr"    = "192.168.12.0/24",
      "gateway" = "192.168.11.1"
    }
  ]

  name           = "newnet"
  mode           = "nat"
  addresses      = ["192.168.10.0/24"]
  domain         = "scratch"
  dhcp           = true
  mtu            = 1500
  autostart      = true
  dns_enabled    = true
  dns_local_only = false
}

module "libvirt_net_override" {
  source         = "../../"
  name           = local.name
  mode           = local.mode
  addresses      = local.addresses
  domain         = local.domain
  dhcp           = local.dhcp
  mtu            = local.mtu
  autostart      = local.autostart
  dns_enabled    = local.dns_enabled
  dns_local_only = local.dns_local_only
  dns_forwarders = local.forwarders
  dns_hosts      = local.hosts
  #routes         = local.routes
}

########### Testing data #########################

# The local variables and the module below are
# used to generate test data for this example.
# They are not needed for the core libvirt
# functionality
locals {
  attributes = {
    expected_name                  = local.name
    expected_mode                  = local.mode
    expected_domain                = local.domain
    expected_mtu                   = tostring(local.mtu)
    expected_address               = "192.168.10.1"
    expected_prefix                = "24"
    expected_dns_enabled           = "yes"
    expected_dhcp_range_start      = "192.168.10.2"
    expected_forwarder_domain1     = local.forwarders.1.domain
    expected_forwarder_addr1       = local.forwarders.1.address
    expected_forwarder_domain2     = local.forwarders.0.domain
    expected_forwarder_addr2       = local.forwarders.0.address
    expected_static_host_ip1       = local.hosts.1.ip
    expected_static_hostname1      = local.hosts.1.hostname
    expected_static_route_address1 = local.routes.1.cidr
    expected_static_route_prefix1  = "24"
    expected_static_route_gateway1 = local.routes.1.gateway
    expected_static_host_ip2       = local.hosts.0.ip
    expected_static_hostname2      = local.hosts.0.hostname
    expected_static_route_address2 = local.routes.0.cidr
    expected_static_route_prefix2  = "24"
    expected_static_route_gateway2 = local.routes.0.gateway
  }
}

module "attributes" {
  source     = "../test_attributes"
  data       = yamlencode(local.attributes)
  test_suite = "override"
}
