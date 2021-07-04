output "name" {
  value = var.name
}

output "id" {
  value = libvirt_network.this_network.id
}
