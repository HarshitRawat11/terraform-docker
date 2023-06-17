# output "container-names" {
#   value       = docker_container.nodered_container[*].name
#   description = "Names of all the containers"
# }

# output "ips-and-ports" {
#   value = [for i in docker_container.nodered_container[*] : join(":", [i.network_data[0].ip_address], i.ports[*].external)]
#   # value = [for i in docker_container.nodered_container[*]: join(":", [i.network_data[0].ip_address, i.ports[0]["external"]])]
#   description = "ips and ports of all the container"
# }

output "application_access" {
    value = {for x in docker_container.app_container[*]: x.name => join(":", x.network_data[*]["ip_address"], x.ports[*]["external"])}   
}