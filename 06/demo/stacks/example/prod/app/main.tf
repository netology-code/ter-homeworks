# Этот файл будет использоваться вместе с автогенерируемыми _backend.tf и _providers.tf

# Создаем случайный пароль для prod окружения (длиннее для безопасности)
resource "random_password" "prod_password" {
  length      = 32
  special     = true
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
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
  value       = length(random_password.prod_password.result)
  description = "Generated password length"
}

