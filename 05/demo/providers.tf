
# Новый подход: использование встроенных блокировок через use_lockfile
terraform {
  required_version = "~>1.12.0"

  backend "s3" {
    
    shared_credentials_files = ["~/.aws/credentials"]
    shared_config_files      = ["~/.aws/config"]
    profile                  = "default"
    region                   = "ru-central1"

    bucket  = "tfstate-develop" # FIO-netology-tfstate
    key     = "dev1/dev1-terraform.tfstate"
    encrypt = false

    # Не требует отдельной базы данных (DynamoDB/YDB)!
    use_lockfile = true

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
  }

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.158.0"
    }
  }
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = "b1gn3ndpua1j6jaabf79"
  folder_id                = "b1gfu61oc15cb99nqmfe"
  service_account_key_file = file("~/.authorized_key.json")
  zone                     = "ru-central1-a" # (Optional) 
}


