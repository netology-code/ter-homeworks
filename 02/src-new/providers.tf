terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"
}

provider "yandex" {
  # token     = var.token
  #cloud_id                 = var.cloud_id
  ##folder_id                = var.folder_id
  #zone                     = var.default_zone
  #service_account_key_file = file("~/.authorized_key.json")
  cloud_id                 = "b1g8fa5kgacq5ib1h509"
  folder_id                = "b1gtnnmljkg2pphuqpge"
  zone                     = "ru-central1-a"
  service_account_key_file = file("~/.authorized_key.json")
}