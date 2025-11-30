terraform {
  required_version = ">= 1.5"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.92.0"
    }
  }

  backend "s3" {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "tf-homework-b1gokds3ue11292eobjh-001"
    key        = "vm/terraform.tfstate"
    access_key = "YCAJE9v1zXNMiZAKk0b77Gx3i"
    secret_key = "YCPM2JXbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    region     = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  folder_id = "b1gokds3ue11292eobjh"
}

# Получаем данные из состояния VPC модуля
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "tf-homework-b1gokds3ue11292eobjh-001"
    key        = "vpc/terraform.tfstate"
    access_key = "YCAJE9v1zXNMiZAKk0b77Gx3i"
    secret_key = "YCPM2JXbXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    region     = "ru-central1"

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

# Статический IP адрес для ВМ
resource "yandex_vpc_address" "vm_ip" {
  name = "vm-static-ip"

  external_ipv4_address {
    zone_id = data.terraform_remote_state.vpc.outputs.zone
  }
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
      image_id = "fd827b91d99psvq5fjit" # Ubuntu 22.04
      size     = 20
    }
  }

  network_interface {
    subnet_id          = data.terraform_remote_state.vpc.outputs.subnet_id
    security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_id]
    nat                = true
    nat_ip_address     = yandex_vpc_address.vm_ip.external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

  labels = {
    environment = "learning"
    project     = "terraform-homework"
  }
}
