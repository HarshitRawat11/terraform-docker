# output "container-names" {
#   value       = flatten(module.container[*].container-names)
#   description = "Names of all the containers"
# }

# output "ips-and-ports" {
#   value = flatten(module.container[*].ips-and-ports)
#   # value = [for i in docker_container.nodered_container[*]: join(":", [i.network_data[0].ip_address, i.ports[0]["external"]])]
#   description = "ips and ports of all the container"
# }

output "application_access" {
  #   value       = [for x in module.container[*] : x]
  value       = module.container
  description = "The name and socket for each application."
}
