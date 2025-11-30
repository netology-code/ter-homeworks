terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.80.0"
    }
  }
}

provider "yandex" {
  cloud_id  = "fake-cloud-id"
  folder_id = "fake-folder-id"
  zone      = "ru-central1-a"
}
