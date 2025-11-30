# Создаем сервисный аккаунт для remote state
resource "yandex_iam_service_account" "remote_state_sa" {
  name        = var.service_account_name
  description = var.service_account_description
}

# Назначаем права на Object Storage
resource "yandex_resourcemanager_folder_iam_member" "storage_editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.remote_state_sa.id}"
}

# Создаем статические ключи доступа
resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.remote_state_sa.id
  description        = "Static access key for Terraform remote state"
}

# Создаем S3 bucket для remote state с версионированием
resource "yandex_storage_bucket" "remote_state" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = false # Можно изменить на true для продакшена
  }
}
