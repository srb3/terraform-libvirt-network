resource "libvirt_network" "this_network" {
  name      = var.name
  mode      = var.mode
  domain    = var.domain
  addresses = var.addresses
  dhcp {
    enabled = var.dhcp
  }
  bridge    = var.bridge_device
  mtu       = var.mtu
  autostart = var.autostart
  dns {
    enabled    = var.dns_enabled
    local_only = var.dns_local_only
    dynamic "forwarders" {
      for_each = toset(var.dns_forwarders)
      content {
        address = forwarders.value["address"]
        domain  = forwarders.value["domain"]
      }
    }
    dynamic "hosts" {
      for_each = toset(var.dns_hosts)
      content {
        hostname = hosts.value["hostname"]
        ip       = hosts.value["ip"]
      }
    }
  }

  dynamic "routes" {
    for_each = toset(var.routes)
    content {
      cidr    = routes.value["cidr"]
      gateway = routes.value["gateway"]
    }
  }
}
