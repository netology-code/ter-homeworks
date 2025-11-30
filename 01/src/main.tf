terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.129.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

provider "docker" {
  host = "ssh://ubuntu@${yandex_compute_instance.vm.network_interface.0.nat_ip_address}:22"
}

resource "yandex_vpc_network" "network" {
  name = "terraform-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "terraform-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_compute_instance" "vm" {
  name        = "my-terraform-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd800c7s2p483i648ifv"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCRD7BVx1bq5n/Ao6SC0QW6NC556i2bS2mJLsSRprLV4gFb7w9UPr3vOv0oUc0hTidD7Co92snCOMbwTTfShg9HkRmBgMch9W0Vn2X6f7FElO/FnZPiB7ev+Pu7N0lURA7p/F5auK2/+AyR0/BT5MmRdLVWi3RrueR/17dArZc2hFePDtZUUlBKfBzyCe7JVf8xAQBOoec1+hawWnz7g7OVjP7vhdCgdhyCd7hLIq8dbQgT6KHYusjFYLx2nOFGkklJfY8ouFi9ai3+HZx58RaT7nJjVcRX/cufzjM+jXS5lSQcBvDzljOUygpzaEWVkv7ofh8XYVXA3fRAeZzGd9Y3 alexlinux@compute-vm-2-2-10-hdd-1762734178104"
  }
}
