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
    key        = "vm/terraform.tfstate"
    access_key = "YCAJE9v1zXNMiZAKk0b77Gx3i"  # Ваш access key
    secret_key = "YCPM2JXbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"  # Ваш secret key
    
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  folder_id = "b1gokds3ue11292eobjh"  # Ваш folder_id
}

# Получаем данные из состояния VPC модуля
data "terraform_remote_state" "vpc" {
  backend = "s3"
  
  config = {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-homework-b1gokds3ue11292eobjh-001"
    key        = "vpc/terraform.tfstate"
    access_key = "YCAJE9v1zXNMiZAKk0b77Gx3i"
    secret_key = "YCPM2JXbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

# Создаем сервисный аккаунт для ВМ
resource "yandex_iam_service_account" "vm_sa" {
  name        = "vm-service-account"
  description = "Service account for virtual machine"
}

# Даем права сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "vm_editor" {
  folder_id = "b1gokds3ue11292eobjh"
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.vm_sa.id}"
}

# Создаем ВМ
resource "yandex_compute_instance" "main" {
  name               = "homework-vm"
  platform_id        = "standard-v3"
  service_account_id = yandex_iam_service_account.vm_sa.id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd827b91d99psvq5fjit"  # Ubuntu 22.04
      size     = 20
    }
  }

  network_interface {
    subnet_id          = data.terraform_remote_state.vpc.outputs.subnet_id
    security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"  # Убедитесь, что у вас есть SSH ключ
  }

  scheduling_policy {
    preemptible = true  # Для экономии средств
  }

  labels = {
    environment = "learning"
    project     = "terraform-homework"
  }
}

# Статический IP адрес для ВМ
resource "yandex_vpc_address" "vm_ip" {
  name = "vm-static-ip"

  external_ipv4_address {
    zone_id = data.terraform_remote_state.vpc.outputs.zone
  }
}

# Привязываем статический IP к ВМ
resource "yandex_compute_instance_update" "vm_with_ip" {
  instance_id = yandex_compute_instance.main.id

  network_interface {
    index        = 0
    ip_address   = yandex_vpc_address.vm_ip.external_ipv4_address[0].address
    subnet_id    = data.terraform_remote_state.vpc.outputs.subnet_id
    nat          = true
  }
}
