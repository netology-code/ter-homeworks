terraform {
  required_providers {
  }
  backend "s3" {
    bucket   = "...."
    endpoint = "storage.yandexcloud.net"
    key      = "..../terraform.tfstate"
    region   = "ru-central1"
    # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
    # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!

    dynamodb_table    = "tfstate-lock-develop" #таблица блокировок
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/........."

    skip_region_validation      = true
    skip_credentials_validation = true
  }
  required_version = ">=1.5"
}
