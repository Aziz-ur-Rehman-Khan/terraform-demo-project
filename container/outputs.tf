output "container-name" {
  value = docker_container.nodered[*].name
}

output "ip_address" {
 # sensitive=true
  value = [ for i in docker_container.nodered[*]: join(":",[i.ip_address],i.ports[*]["external"]) ]
}
