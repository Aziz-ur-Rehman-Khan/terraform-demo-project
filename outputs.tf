output "container-name" {
  value = module.container[*].container-name
}

output "ip_address" {
  sensitive=true
  value = flatten(module.container[*].ip_address)
}
