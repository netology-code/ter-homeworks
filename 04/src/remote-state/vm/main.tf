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
    bucket     = "net-ter-04-bucket"
    region     = "ru-central1"
    key        = "vm/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum = true
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

# Получаем данные о VPC из remote state
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "net-ter-04-bucket"
    region     = "ru-central1"
    key        = "vpc/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true

    access_key = var.yc_access_key
    secret_key = var.yc_secret_key
  }
}

resource "yandex_compute_instance" "vm" {
  name        = "test-vm"
  platform_id = "standard-v3"
  zone        = var.yc_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd87va5cc00gaq2f5qfb" # Ubuntu 20.04
      size     = 10
    }
  }

  network_interface {
    subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/decimal.pub")}"
  }
}

output "vm_ip" {
  value = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}