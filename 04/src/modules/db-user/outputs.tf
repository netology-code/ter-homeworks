output "database_name" {
  value = yandex_mdb_mysql_database.db.name
}

output "user_name" {
  value = yandex_mdb_mysql_user.user.name
}
