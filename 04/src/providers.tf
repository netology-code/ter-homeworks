terraform {
  required_providers {

    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.161.0"
    }

    vault= {
      source = "hashicorp/vault"
      version = "5.3.0"
    }

    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }

  }
  required_version = "~>1.8.4"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gt80gaili3c9dsg6oe/etnkic6v51149s4gtv47"
    }  
    bucket     = "netology-bucket-04"
    region     = "ru-central1"
    key       = "vm/terraform.tfstate"
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
    skip_metadata_api_check     = true

    dynamodb_table   = "terraform-lock"
  }
}

provider "yandex" {
  #token     = var.token
  service_account_key_file = file("~/.authorized_key.json")
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

