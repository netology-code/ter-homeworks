# Примеры использования модуля mysql-database

# Простая база данных и пользователь
module "webapp_database" {
  source       = "./modules/mysql-database"
  cluster_id   = module.mysql_ha.cluster_id  # ID от созданного кластера
  database_name = "webapp"
  username     = "webapp_user"
  password     = "secure_webapp_password_123"
}

# База данных с кастомными правами
module "analytics_database" {
  source       = "./modules/mysql-database"
  cluster_id   = module.mysql_ha.cluster_id
  database_name = "analytics"
  username     = "analytics_user"
  password     = "secure_analytics_password_456"
  
  permissions = [{
    database_name = "analytics"
    roles         = ["SELECT", "INSERT", "UPDATE"]
  }]
  
  connection_limit = 50
}

# Пользователь с доступом к нескольким базам
module "admin_user" {
  source     = "./modules/mysql-database"
  cluster_id = module.mysql_ha.cluster_id
  database_name = "admin_db"
  username   = "admin_app"
  password   = "secure_admin_password_789"
  
  permissions = [
    {
      database_name = "webapp"
      roles         = ["SELECT"]
    },
    {
      database_name = "analytics" 
      roles         = ["ALL"]
    },
    {
      database_name = "admin_db"
      roles         = ["ALL"]
    }
  ]
  
  global_permissions = ["PROCESS"]
}

# Outputs для проверки
output "webapp_database_name" {
  value = module.webapp_database.database_name
}

output "analytics_username" {
  value = module.analytics_database.username
}
