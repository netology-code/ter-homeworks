terraform {
  required_providers { 
     yandex = {
       source = "yandex-cloud/yandex"
     }
  }
    required_version = ">=0.13"
}
 provider "yandex" {
    token  =  var.token
    cloud_id  = var.cloud_id
    folder_id = var.folder_id
    zone      = "ru-central1-a"
 }
resource "yandex_vpc_network" "develop" {
  name = "develop"
}
resource "yandex_vpc_subnet" "develop" {
  name           = "develop"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "platform" {
  name        = "netology-develop-platform-web"
  platform_id = "standard-v1"
  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.example.id
    nat       = true
  }
}
