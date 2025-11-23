output "database_name" {
  value = yandex_mdb_mysql_database.database.name
}

output "username" {
  value = yandex_mdb_mysql_user.user.name
}

output "user_connection_limit" {
  value = yandex_mdb_mysql_user.user.connection_limit
}

output "user_permissions" {
  value = yandex_mdb_mysql_user.user.permission
}
