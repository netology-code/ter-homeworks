resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  name        = var.cluster_name
  environment = var.environment
  network_id  = var.network_id
  version     = var.mysql_version

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  # Динамическое создание хостов в зависимости от HA режима
  dynamic "host" {
    for_each = var.ha ? range(var.host_count) : range(1)
    
    content {
      zone      = var.zones[host.key % length(var.zones)]
      subnet_id = var.subnet_ids[host.key % length(var.subnet_ids)]
    }
  }

  database {
    name = "default_db"
  }

  user {
    name     = var.username
    password = var.password
    permission {
      database_name = "default_db"
      roles         = ["ALL"]
    }
  }

  # Настройки HA
  backup_window_start {
    hours   = 23
    minutes = 59
  }

  maintenance_window {
    type = "ANYTIME"
  }
}
