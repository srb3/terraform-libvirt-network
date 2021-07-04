variable "name" {
  description = "The name of the network to create"
  type        = string
}

variable "mode" {
  description = "The networking mode to use. Can be: nat, none, route, bridge"
  type        = string
  default     = "nat"
}

variable "domain" {
  description = "The domain to be used by the dns servers in this network"
  type        = string
  default     = null
}

variable "addresses" {
  description = "list of subnets the addresses allowed for the network"
  type        = list(string)
  default     = []
}

variable "dhcp" {
  description = "Should dhcp be enabled. Used in conjuction with the addresses variable"
  type        = bool
  default     = false
}

variable "bridge_device" {
  description = "If bridged networking mode is selected then set the device name here"
  type        = string
  default     = null
}

variable "mtu" {
  description = "The mtu size to use, defaults to the underlying device"
  type        = number
  default     = null
}

variable "autostart" {
  description = "Should the network be set to autostart"
  type        = bool
  default     = false
}

variable "dns_enabled" {
  description = "Should we enable dns on this network"
  type        = bool
  default     = false
}

variable "dns_local_only" {
  description = "DNS requests under this domain will only be resolved by the dns server"
  type        = bool
  default     = true
}

variable "dns_forwarders" {
  description = "A list of maps that configure a dns server address and the domains they service"
  type        = list(map(string))
  default     = []
}

variable "dns_hosts" {
  description = "A list of maps that configure staic hosts for the dns server"
  type        = list(map(string))
  default     = []
}

variable "routes" {
  description = "A list of maps that configure staic routes for this network"
  type        = list(map(string))
  default     = []
}

variable "dnsmasq_options" {
  description = "A list of maps that configure dnsmaq options"
  type        = list(map(string))
  default     = []
}
