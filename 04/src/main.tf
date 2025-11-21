terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 1.0"
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

# ВМ для marketing проекта
resource "yandex_compute_instance" "marketing_vm" {
  name        = "marketing-vm"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 22.04
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
    user-data = data.template_file.cloud_init.rendered
  }

  labels = {
    project     = "marketing"
    department  = "marketing"
    environment = "production"
    managed-by  = "terraform"
  }
}

# ВМ для analytics проекта
resource "yandex_compute_instance" "analytics_vm" {
  name        = "analytics-vm"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 22.04
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
    user-data = data.template_file.cloud_init.rendered
  }

  labels = {
    project     = "analytics"
    department  = "analytics"
    environment = "production"
    managed-by  = "terraform"
  }
}
# Отдельные шаблоны для каждого проекта
data "template_file" "cloud_init_marketing" {
  template = file("${path.module}/templates/cloud-init.yml")

  vars = {
    ssh_public_key = var.vms_ssh_root_key
    vm_project     = "marketing"
  }
}

data "template_file" "cloud_init_analytics" {
  template = file("${path.module}/templates/cloud-init.yml")

  vars = {
    ssh_public_key = var.vms_ssh_root_key
    vm_project     = "analytics"
  }
}
