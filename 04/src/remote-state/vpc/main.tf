terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "net-ter-04-bucket" # Замените на имя вашего bucket
    region     = "ru-central1"
    key        = "vpc/terraform.tfstate"
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true

  
}
}



provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

resource "yandex_vpc_network" "main" {
  name        = "main-network"
  description = "Main network for VMs"
}

resource "yandex_vpc_subnet" "main" {
  name           = "main-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}



output "network_id" {
  value = yandex_vpc_network.main.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.main.id
}