# Single-host MySQL кластер с БД и пользователем
module "mysql_example_single" {
  source      = "./modules/mysql-cluster"
  cluster_name = "example"
  network_id  = yandex_vpc_network.production.id
  ha          = false  # Single host
  host_count  = 1
  
  subnet_ids = [
    yandex_vpc_subnet.production.id  # Используем существующую подсеть
  ]
  
  username = "admin"
  password = "secure_admin_password_123"
}

# Создаем БД test и пользователя app в кластере
module "example_database" {
  source       = "./modules/mysql-database"
  cluster_id   = module.mysql_example_single.cluster_id
  database_name = "test"
  username     = "app"
  password     = "secure_app_password_456"
  
  # Даем пользователю app права на базу test
  permissions = [{
    database_name = "test"
    roles         = ["ALL"]
  }]
}

# Outputs для проверки
output "single_cluster_id" {
  value = module.mysql_example_single.cluster_id
}

output "single_cluster_hosts" {
  value = module.mysql_example_single.hosts
}

output "database_name" {
  value = module.example_database.database_name
}

output "app_username" {
  value = module.example_database.username
}
