output "cluster_id" {
  value = yandex_mdb_mysql_cluster.this.id
}

output "hosts" {
  value = yandex_mdb_mysql_cluster.this.host
}

output "fqdn" {
  value = yandex_mdb_mysql_cluster.this.host[0].fqdn
}