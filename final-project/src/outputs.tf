# output "web_vm_public_ips" {
#   value = {
#     for vm in module.project:
#     vm.name => vm.network_interface.0.nat_ip_address
#   }
# }

# output "mysql_host" {
#   value = yandex_mdb_mysql_cluster.mysql.host[0].fqdn
# }

# output "registry_id" {
#   value = yandex_container_registry.main.id
# }