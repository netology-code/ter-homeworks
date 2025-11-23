# Пример использования модуля MySQL кластера
# Single-host кластер (HA = false)
module "mysql_single" {
  source = "./modules/mysql-cluster"

  cluster_name = "mysql-single-node"
  network_id   = yandex_vpc_network.production.id
  ha           = false
  host_count   = 1
  
  subnet_ids = [
    module.vpc_prod.subnet_ids["ru-central1-a"]
  ]
  
  username = "admin"
  password = "secure_password_123"
}

# Multi-host кластер (HA = true)
module "mysql_ha" {
  source = "./modules/mysql-cluster"

  cluster_name = "mysql-ha-cluster"
  network_id   = yandex_vpc_network.production.id
  ha           = true
  host_count   = 2
  
  subnet_ids = [
    module.vpc_prod.subnet_ids["ru-central1-a"],
    module.vpc_prod.subnet_ids["ru-central1-b"]
  ]
  
  username = "admin"
  password = "secure_password_456"
}

# Outputs для проверки
output "single_cluster_fqdn" {
  value = module.mysql_single.fqdn
}

output "ha_cluster_hosts" {
  value = module.mysql_ha.hosts
}
