terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.8.4"




backend "s3" {
    
    shared_credentials_files = ["~/.aws/credentials"]
    shared_config_files = [ "~/.aws/config" ]
    profile = "default"
    region="ru-central1"

    bucket     = "backet-olov" #FIO-netology-tfstate
    key = "production/terraform.tfstate"
    

    # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
    # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!


    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  endpoints ={
    #dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gn3ndpua1j6jaabf79/etnij6ph9brodq9ohs8d"
    s3 = "https://storage.yandexcloud.net"
  }

    #dynamodb_table              = "tfstate-lock-develop"
  }
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