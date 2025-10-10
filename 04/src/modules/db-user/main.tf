terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_mdb_mysql_database" "db" {
    cluster_id = var.cluster_id
    name = var.database_name
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = var.cluster_id
  name       = var.user_name
  password   = var.user_password

  dynamic "permission" {
    for_each = toset(var.user_permissions)
    content {
      database_name = permission.value
      roles         = ["ALL"]
    }
  }
}