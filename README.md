# terraform-libvirt-network

A terraform module for creating libvirt neworks

## Usage

### Using module defaults

The following code example will create a libvirt
network with the name of test, in a flat network no
NAT or bridging and with a CIDR of 192.168.10.0/24

```HCL
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
```

### Overrding most defaults

```HCL
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
```
## Testing

This module uses [cinc-auditor](https://cinc.sh/start/auditor/) as a test framework.
To install you can use the [download page](https://cinc.sh/download/) and the
[getting started guid](https://cinc.sh/start/auditor/). The auditor test are
located in the [test --> integration directory](./test/integration).
There is a [make file](./Makefile)
in the root of the repo that takes care of orchestrating the tests
