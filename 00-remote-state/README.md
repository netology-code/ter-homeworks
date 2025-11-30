# Terraform Remote State Module

Этот модуль создает инфраструктуру для хранения Terraform state в Yandex Cloud Object Storage.

## Создаваемые ресурсы

- **S3 Bucket**: для хранения Terraform state с включенным версионированием
- **Service Account**: с правами `storage.editor` для работы с bucket
- **Static Access Keys**: для аутентификации Terraform

## Использование

------
module "remote_state" {
  source = "./00-remote-state"

  cloud_id  = "your-cloud-id"
  folder_id = "your-folder-id"
  bucket_name = "your-unique-bucket-name"
}

# После применения, используйте outputs для настройки backend
