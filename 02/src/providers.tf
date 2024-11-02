terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "<=1.9.8"
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.authorized_key.json")
}

# provider "yandex" {
#   # token     = var.token
#   cloud_id                 = "b1gebvnp4l01pjj94h8g"
#   folder_id                = "b1gll1nj110e9uebdvrq"
#   # zone                     = "ru-central1-a"
#   service_account_key_file = file("~/.authorized_key.json")
# }
