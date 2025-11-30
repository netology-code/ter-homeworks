# Имя bucket
output "bucket_name" {
  value       = yandex_storage_bucket.remote_state.bucket
  description = "Name of the S3 bucket for remote state"
}

# Access Key ID (sensitive)
output "access_key_id" {
  value       = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  description = "Access Key ID for the service account"
  sensitive   = true
}

# Secret Access Key (sensitive)
output "secret_access_key" {
  value       = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  description = "Secret Access Key for the service account"
  sensitive   = true
}

# Service Account ID
output "service_account_id" {
  value       = yandex_iam_service_account.remote_state_sa.id
  description = "ID of the service account"
}

# Пример конфигурации backend
output "backend_configuration_example" {
  value = <<EOT
# Пример конфигурации backend для использования:
terraform {
  backend "s3" {
    bucket     = "${yandex_storage_bucket.remote_state.bucket}"
    key        = "terraform/terraform.tfstate"
    region     = "ru-central1"
    access_key = "${yandex_iam_service_account_static_access_key.sa_static_key.access_key}"
    secret_key = "${yandex_iam_service_account_static_access_key.sa_static_key.secret_key}"
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
EOT
  description = "Example backend configuration for Terraform"
}

# Команда для инициализации с новым backend
output "init_command" {
  value = <<EOT
# Команда для инициализации Terraform с новым backend:
terraform init -migrate-state
EOT
  description = "Terraform init command for migrating state"
}
