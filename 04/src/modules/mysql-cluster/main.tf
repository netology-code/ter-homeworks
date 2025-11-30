# Создание базы данных в кластере MySQL
resource "yandex_mdb_mysql_database" "database" {
  cluster_id = var.cluster_id
  name       = var.database_name
}

# Создание пользователя с правами на базу данных
resource "yandex_mdb_mysql_user" "user" {
  cluster_id = var.cluster_id
  name       = var.username
  password   = var.password

  dynamic "permission" {
    for_each = var.permissions
    content {
      database_name = permission.value.database_name
      roles         = permission.value.roles
    }
  }

  dynamic "permission" {
    for_each = length(var.global_permissions) > 0 ? [1] : []
    content {
      database_name = "*" # Глобальные права
      roles         = var.global_permissions
    }
  }

  connection_limit = var.connection_limit
}
