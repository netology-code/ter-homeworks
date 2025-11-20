
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

# Создание VPC
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Шаблон cloud-init с переменной для SSH ключа
data "template_file" "cloud_init" {
  template = file("${path.module}/templates/cloud-init.yml")
  
  vars = {
    ssh_public_key = var.vms_ssh_root_key
  }
}

# Модуль для marketing проекта
module "marketing_vm" {
  source = "github.com/netology-code/ter-homeworks//04/demonstration1?ref=main"
  
  # Параметры ВМ
  vm_name     = "marketing-vm"
  vm_zone     = var.default_zone
  network_id  = yandex_vpc_network.develop.id
  subnet_id   = yandex_vpc_subnet.develop.id
  
  # Cloud-init конфигурация
  user_data = data.template_file.cloud_init.rendered
  
  # Labels для обозначения принадлежности
  labels = {
    project    = "marketing"
    department = "marketing"
    environment = "production"
  }
}

# Модуль для analytics проекта
module "analytics_vm" {
  source = "github.com/netology-code/ter-homeworks//04/demonstration1?ref=main"
  
  # Параметры ВМ
  vm_name     = "analytics-vm"
  vm_zone     = var.default_zone
  network_id  = yandex_vpc_network.develop.id
  subnet_id   = yandex_vpc_subnet.develop.id
  
  # Cloud-init конфигурация
  user_data = data.template_file.cloud_init.rendered
  
  # Labels для обозначения принадлежности
  labels = {
    project    = "analytics"
    department = "analytics"
    environment = "production"
  }
}
