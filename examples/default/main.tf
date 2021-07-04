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
  name      = "test"
  mode      = "none"
  addresses = ["192.168.10.0/24"]

}

module "libvirt_net" {
  source    = "../../"
  name      = local.name
  mode      = local.mode
  addresses = local.addresses
}
