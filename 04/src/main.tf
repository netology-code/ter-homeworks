terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

# Production VPC с подсетями во всех зонах
module "vpc_prod" {
  source   = "./modules/vpc"
  env_name = "production"

  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

# Development VPC с одной подсетью
module "vpc_dev" {
  source   = "./modules/vpc"
  env_name = "develop"

  subnets = [
    { zone = "ru-central1-a", cidr = "10.10.1.0/24" },
  ]
}

# Виртуальные машины используют подсети из production VPC
resource "yandex_compute_instance" "marketing_vm" {
  name        = "marketing-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk"
      size     = 20
    }
  }

  network_interface {
    subnet_id = module.vpc_prod.subnet_ids["ru-central1-a"]
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/terraform_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "analytics_vm" {
  name        = "analytics-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk"
      size     = 20
    }
  }

  network_interface {
    subnet_id = module.vpc_prod.subnet_ids["ru-central1-a"]
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/terraform_rsa.pub")}"
  }
}
