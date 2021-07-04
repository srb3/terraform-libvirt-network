#variable "name" {}                           # matches module default
#variable "domain" { default = null }         # matches module default
#variable "mode" { default = "nat" }          # matches module default
#variable "addresses" { default = [] }        # matches module default
#variable "dhcp" { default = false }          # matches module default
#variable "bridge_device" { default = null }  # matches module default
#variable "mtu" { default = null }            # matches module default
#variable "autostart" { default = false }     # matches module default
#variable "dns_enabled" { default = false }   # matches module default
#variable "dns_local_only" { default = true } # matches module default
#variable "dns_forwarders" { default = [] }   # matches module default
#variable "dns_hosts" { default = [] }        # matches module default
#variable "dnsmasq_options" { default = [] }  # matches module default
#variable "routes" { default = [] }           # matches module default
#

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
  routes         = local.routes
}
