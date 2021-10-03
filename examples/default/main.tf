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

########### Testing data #########################

# The local variables and the module below are
# used to generate test data for this example.
# They are not needed for the core libvirt
# functionality
locals {
  attributes = {
    expected_network_name    = local.name
    expected_network_address = "192.168.10.1"
    expected_mode            = local.mode
    expected_network_prefix  = "24"
    expected_dns_enabled     = "no"
  }
}

module "attributes" {
  source     = "../test_attributes"
  data       = yamlencode(local.attributes)
  test_suite = "default"
}
