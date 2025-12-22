#MySQL Cluster Module
##Модуль для создания Managed MySQL кластера в Yandex Cloud с поддержкой HA.
## Использование
### Single-host кластер:
module "mysql_single" {
  source      = "./modules/mysql-cluster"
  cluster_name = "mysql-single"
  network_id  = "network-123"
  ha          = false
  subnet_ids  = ["subnet-123"]
  username    = "admin"
  password    = "secure_password"
}
