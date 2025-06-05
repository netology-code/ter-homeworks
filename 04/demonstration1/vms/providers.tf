terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.8.4"
}

# provider "yandex" {
#   # token                    = "do not use!!!"
#   cloud_id                 = "b1gn3ndpua1j6jaabf79"
#   folder_id                = "b1gfu61oc15cb99nqmfe"
#   service_account_key_file = file("~/.authorized_key.json")
#   zone                     = "ru-central1-a" #(Optional) 
# }

provider "yandex" {
#  token     = var.token # del
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
  service_account_key_file = file("~/.authorized_key.json") #add
}