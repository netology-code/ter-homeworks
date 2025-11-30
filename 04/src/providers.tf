terraform {
  required_version = "~>1.9.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.172.0"
    }
  }

  backend "s3" {
    bucket                      = "terraform-state-bucket-1764042687"
    key                         = "terraform.tfstate"
    region                      = "ru-central1"
    endpoints                   = { s3 = "https://storage.yandexcloud.net" }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
