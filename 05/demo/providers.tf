
# cat ~/.aws/config 
# [default]
# region=ru-central1
# cat ~/.aws/credentials 
# [default]
# aws_access_key_id = YCAJEK...
# aws_secret_access_key = YCMBzZ3...


#For terraform >=1.6<=1.8.5
terraform {
  required_version = "1.8.4"

  backend "s3" {
    
    shared_credentials_files = ["~/.aws/credentials"]
    shared_config_files = [ "~/.aws/config" ]
    profile = "default"
    region="ru-central1"

    bucket     = "tfstate-develop" #FIO-netology-tfstate
    key = "production/terraform.tfstate"
    

    # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
    # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!


    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

  endpoints ={
    dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gn3ndpua1j6jaabf79/etnij6ph9brodq9ohs8d"
    s3 = "https://storage.yandexcloud.net"
  }

    dynamodb_table              = "tfstate-lock-develop"
  }

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.118.0"
    }
  }
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id                 = "b1gn3ndpua1j6jaabf79"
  folder_id                = "b1gfu61oc15cb99nqmfe"
  service_account_key_file = file("~/.authorized_key.json")
  zone                     = "ru-central1-a" #(Optional) 
}



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

#     dynamodb_table    = "tfstate-lock-develop" #таблица блокировок
#     dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/........."

#     skip_region_validation      = true
#     skip_credentials_validation = true
#   }
#   required_version = "~>1.8.4"
# }
