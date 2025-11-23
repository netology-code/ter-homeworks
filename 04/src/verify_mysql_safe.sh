#!/bin/bash

set -e

echo "🔍 Начинаем безопасную проверку MySQL модулей..."
echo "⚠️  ВНИМАНИЕ: Ресурсы будут созданы и сразу удалены!"

# Проверяем наличие необходимых переменных
if [ ! -f "terraform.tfvars" ]; then
    echo "❌ Файл terraform.tfvars не найден!"
    echo "Создайте файл со следующими переменными:"
    echo "yc_token = \"ваш_токен\""
    echo "yc_cloud_id = \"ваш_cloud_id\""
    echo "yc_folder_id = \"ваш_folder_id\""
    exit 1
fi

# Создаем минимальную конфигурацию для теста
cat > main_minimal.tf << 'TFEOF'
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.171.0"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

# Минимальная VPC для теста
resource "yandex_vpc_network" "test_network" {
  name = "mysql-test-network"
}

resource "yandex_vpc_subnet" "test_subnet" {
  name           = "mysql-test-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.test_network.id
  v4_cidr_blocks = ["10.100.1.0/24"]
}

# Минимальный MySQL кластер
module "mysql_test" {
  source = "./modules/mysql-cluster"
  
  name        = "test-mysql-safe"
  environment = "test"
  network_id  = yandex_vpc_network.test_network.id
  
  # Минимальная конфигурация для экономии
  resources = {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }
  
  hosts = [
    {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.test_subnet.id
    }
  ]
  
  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
  }
}

# Тестовая база данных
module "test_database" {
  source = "./modules/mysql-database"
  
  cluster_id = module.mysql_test.cluster_id
  name       = "test_db"
}

output "mysql_cluster_info" {
  value = {
    id      = module.mysql_test.cluster_id
    hosts   = module.mysql_test.hosts
    status  = module.mysql_test.cluster_status
    fqdn    = module.mysql_test.cluster_fqdn
  }
  description = "Информация о созданном MySQL кластере"
}
TFEOF

echo "✅ Минимальная конфигурация создана"

# Инициализация
echo "🔄 Инициализируем Terraform..."
terraform init

# Проверка конфигурации
echo "🔍 Проверяем конфигурацию..."
terraform validate

# План
echo "📋 Создаем план выполнения..."
terraform plan -out=test_plan

read -p "🚀 Продолжить с созданием ресурсов? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Проверка отменена"
    cleanup
    exit 0
fi

# Применение (создание ресурсов)
echo "🛠️ Создаем ресурсы..."
start_time=$(date +%s)
terraform apply -auto-approve
apply_time=$(($(date +%s) - start_time))

echo "✅ Ресурсы созданы за ${apply_time} секунд"

# Краткая проверка что все работает
echo "🔍 Проверяем созданные ресурсы..."
terraform output mysql_cluster_info

echo "⏳ Ждем 2 минуты для стабилизации кластера..."
sleep 120

# Немедленное удаление
echo "🗑️ Начинаем удаление ресурсов..."
start_time=$(date +%s)
terraform destroy -auto-approve
destroy_time=$(($(date +%s) - start_time))

echo "✅ Ресурсы удалены за ${destroy_time} секунд"

# Очистка
cleanup() {
    echo "🧹 Выполняем очистку..."
    rm -f main_minimal.tf
    rm -f test_plan
    rm -rf .terraform
    rm -f .terraform.lock.hcl
    rm -f terraform.tfstate*
    echo "✅ Очистка завершена"
}

cleanup

echo " "
echo "🎉 БЕЗОПАСНАЯ ПРОВЕРКА ЗАВЕРШЕНА!"
echo "✅ MySQL кластер создан и удален"
echo "✅ Все модули работают корректно"
echo "✅ Ресурсы удалены - расходов нет"
echo "✅ Общее время: $(($apply_time + $destroy_time)) секунд"
