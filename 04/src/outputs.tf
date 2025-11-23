output "cluster_id" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.id
}

output "cluster_name" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.name
}

output "hosts" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.host
}

output "fqdn" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.host[0].fqdn
}

output "connection_string" {
  value = "mysql -h ${yandex_mdb_mysql_cluster.mysql_cluster.host[0].fqdn} -u ${var.username} -p"
  sensitive = true
}
