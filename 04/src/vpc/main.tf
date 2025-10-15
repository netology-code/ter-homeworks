terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gt80gaili3c9dsg6oe/etnkic6v51149s4gtv47"
    }   
    bucket     = "netology-bucket-04"
    region     = "ru-central1"
    key       = "vpc/terraform.tfstate"
    
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

module "vpc_develop" {
  source       = "../modules/vpc"
  network_name = "dev-network"
  subnet_name  = "dev-subnet"
  
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    # { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    # { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}

output "network_id" {
  value = module.vpc_develop.network.id
}

output "subnet_ids" {
  value = module.vpc_develop.subnet_ids
}
