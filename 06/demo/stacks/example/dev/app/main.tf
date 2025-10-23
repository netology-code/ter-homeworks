# Этот файл будет использоваться вместе с автогенерируемыми _backend.tf и _providers.tf

# Создаем случайный пароль для dev окружения
resource "random_password" "dev_password" {
  length  = 16
  special = true
}

# Создаем случайную строку для имени приложения
resource "random_string" "app_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Локальные переменные
locals {
  app_name    = "${global.project}-${global.environment}-app-${random_string.app_suffix.result}"
  environment = global.environment
  region      = global.region
}

# Output значения
output "app_name" {
  value       = local.app_name
  description = "Generated application name"
}

output "environment" {
  value       = local.environment
  description = "Current environment"
}

output "password_length" {
  value       = length(random_password.dev_password.result)
  description = "Generated password length"
}

