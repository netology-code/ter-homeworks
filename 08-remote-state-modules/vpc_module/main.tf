terraform {
  required_version = ">= 1.5"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.92.0"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-homework-b1gokds3ue11292eobjh-001"  # Ваш bucket из задания 6*
    key        = "vpc/terraform.tfstate"
    access_key = "YCAJE9v1zXNMiZAKk0b77Gx3i"  # Ваш access key
    secret_key = "YCPM2JXbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"  # Ваш secret key
    
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  folder_id = "b1gokds3ue11292eobjh"  # Ваш folder_id
}

# Создаем VPC сеть
resource "yandex_vpc_network" "main" {
  name        = "main-network"
  description = "Main network for homework"
}

# Создаем подсеть
resource "yandex_vpc_subnet" "main" {
  name           = "main-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  
  labels = {
    environment = "learning"
    project     = "terraform-homework"
  }
}

# Группа безопасности
resource "yandex_vpc_security_group" "main" {
  name        = "main-security-group"
  description = "Main security group for VMs"
  network_id  = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "SSH access"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP access"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS access"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    protocol       = "ANY"
    description    = "Outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
