terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.92.0"
    }
  }
}

provider "yandex" {
  folder_id = "b1gokds3ue11292eobjh"
}

# Создаем сервисный аккаунт для бакета
resource "yandex_iam_service_account" "s3_sa" {
  name        = "s3-bucket-sa"
  description = "Service account for S3 bucket management"
}

# Даем права на storage.editor
resource "yandex_resourcemanager_folder_iam_member" "s3_editor" {
  folder_id = "b1gokds3ue11292eobjh"
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.s3_sa.id}"
}

# Создаем статические ключи доступа
resource "yandex_iam_service_account_static_access_key" "s3_sa_keys" {
  service_account_id = yandex_iam_service_account.s3_sa.id
  description        = "Static access keys for S3 bucket"
}

# Создаем S3 бакет с фиксированным уникальным именем
resource "yandex_storage_bucket" "homework_bucket" {
  # Используем фиксированное имя на основе folder_id без дефисов + суффикс
  bucket     = "tf-homework-${replace("b1gokds3ue11292eobjh", "-", "")}-001"
  access_key = yandex_iam_service_account_static_access_key.s3_sa_keys.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3_sa_keys.secret_key

  max_size = 1073741824 # 1 GB in bytes

  anonymous_access_flags {
    read = false
    list = false
  }

  # Пропускаем versioning чтобы избежать ошибок прав доступа
  # Бакет будет создан успешно без versioning
}
