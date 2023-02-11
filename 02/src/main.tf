terraform {
  required_providers { 
     yandex = {
       source = "yandex-cloud/yandex"
     }
  }
    required_version = ">=0.13"
}
 provider "yandex" {
   token  =  "<OAuth-токен>"
   cloud_id  = "<идентификатор_облака>"
   folder_id = "<идентификатор_каталога>"
   zone      = "ru-central1-a"
 }

resource "yandex_vpc_network" "example" {
  name = "example"
}

resource "yandex_vpc_subnet" "example" {
  name           = "example-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.example.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "example" {
  name        = "example"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.example.id
  }

}
