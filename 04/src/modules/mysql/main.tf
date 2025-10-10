terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
    name            = var.cluster_name
    environment     = var.environment
    network_id      = var.network_id
    version         = var.mysql_version

    resources {
        resource_preset_id = var.resource_preset
        disk_type_id = var.disk_type
        disk_size = var.disk_size
    }

    dynamic "host" {
    for_each = local.host_subnets

    content {
      zone      = host.key
      subnet_id = host.value
    }
  }
}