# main.tf

terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.171.0"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

# Модуль VPC (заменяет прямые ресурсы yandex_vpc_network и yandex_vpc_subnet)
module "vpc" {
  source = "./modules/vpc"

  # Передаем параметры сети
  network_name = "production-network"
  subnet_name  = "production-subnet"
  zone         = "ru-central1-a"
  cidr_blocks  = "192.168.100.0/24"
}

# Модуль marketing_vm с передачей параметров из модуля VPC
module "marketing_vm" {
  source = "./modules/marketing_vm"

  # Передаем subnet_id из модуля VPC
  subnet_id      = module.vpc.subnet_id
  ssh_public_key = var.vms_ssh_root_key
  zone           = module.vpc.zone  # передаем zone из модуля VPC
}

# Ресурс analytics_vm с передачей параметров из модуля VPC
resource "yandex_compute_instance" "analytics_vm" {
  name        = "analytics-vm"
  platform_id = "standard-v3"
  zone        = module.vpc.zone  # используем zone из модуля VPC

  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd84nt41ssoaapgql97p"
      size     = 20
    }
  }

  network_interface {
    subnet_id = module.vpc.subnet_id  # используем subnet_id из модуля VPC
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  }

  labels = {
    environment = "analytics"
    owner       = "analytics-team"
    project     = "terraform"
  }
}

# Вывод информации
#output "marketing_vm_ip" {
  #description = "External IP address of the marketing VM"
  #value       = module.marketing_vm.external_ip
#}

#output "analytics_vm_ip" {
  #description = "External IP address of the analytics VM"
  #value       = yandex_compute_instance.analytics_vm.network_interface[0].nat_ip_address
#}
