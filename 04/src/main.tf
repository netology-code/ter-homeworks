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

# Настройка провайдера Yandex.Cloud
provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

# УДАЛИТЕ эти ресурсы - они дублируют модуль VPC
# resource "yandex_vpc_network" "network" {
#   name = "marketing-network"
# }
#
# resource "yandex_vpc_subnet" "subnet" {
#   name           = "marketing-subnet"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.network.id
#   v4_cidr_blocks = ["192.168.60.0/24"]
# }

# Модуль VPC (создает сеть и подсеть)
module "vpc" {
  source = "./modules/vpc"

  network_name = "terraform-network"
  subnet_name  = "terraform-subnet"
  zone         = "ru-central1-a"
  cidr_blocks  = "192.168.60.0/24"
}

# Вызов модуля marketing_vm
module "marketing_vm" {
  source = "./modules/marketing_vm"

  # Передача переменных в модуль
  subnet_id      = module.vpc.subnet_id  # ИСПРАВЛЕНО: subnet_id, а не subnet.id
  ssh_public_key = var.vms_ssh_root_key
  zone           = "ru-central1-a"
}

# Ресурс analytics_vm
resource "yandex_compute_instance" "analytics_vm" {
  name        = "analytics-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd84nt41ssoaapgql97p" # Ubuntu 22.04 - ваш образ
      size     = 20
    }
  }

  network_interface {
    subnet_id = module.vpc.subnet_id  # ИСПРАВЛЕНО: subnet_id, а не subnet.id
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

# Вывод информации о созданных VM
output "marketing_vm_ip" {
  description = "External IP address of the marketing VM"
  value       = module.marketing_vm.external_ip
}

output "analytics_vm_ip" {
  description = "External IP address of the analytics VM"
  value       = yandex_compute_instance.analytics_vm.network_interface[0].nat_ip_address
}
