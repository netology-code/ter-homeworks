
# cat ~/.aws/config 
# [default]
# region=ru-central1
# cat ~/.aws/credentials 
# [default]
# aws_access_key_id = YCAJEK...
# aws_secret_access_key = YCMBzZ3...


# For terraform >=1.6.0
# Новый подход: использование встроенных блокировок через use_lockfile
terraform {
  required_version = "~>1.12.0"

  backend "s3" {
    
    shared_credentials_files = ["~/.aws/credentials"]
    profile                  = "default"
    region                   = "ru-central1"

    bucket  = "tfstate-develop" # FIO-netology-tfstate
    key     = "dev1/dev1-terraform.tfstate"
    encrypt = false

    # НОВОЕ: Встроенный механизм блокировок (Terraform >= 1.6)
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



# УСТАРЕВШИЙ ПОДХОД - для справки
# For terraform <1.6.0
# terraform {
#   required_providers {
#   }
#   backend "s3" {
#     bucket   = "...."
#     endpoint = "storage.yandexcloud.net"
#     key      = "..../terraform.tfstate"
#     region   = "ru-central1"
#     # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
#     # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
#
#     # СТАРЫЙ СПОСОБ: требовал создания YDB в режиме DynamoDB
#     dynamodb_table    = "tfstate-lock-develop" # таблица блокировок
#     dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/........."
#
#     endpoints = {
#       dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/..."
#       s3       = "https://storage.yandexcloud.net"
#     }
#
#     skip_region_validation      = true
#     skip_credentials_validation = true
#   }
#   required_version = "~>1.8.4"
# }
