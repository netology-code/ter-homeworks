terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"
}

provider "yandex" {
  cloud_id                 = var.id.cloud_id
  folder_id                = var.id.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/authorized_key.json")
}

