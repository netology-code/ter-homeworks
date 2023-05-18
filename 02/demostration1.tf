# Не забываем добавить блок авторизации
terraform {
  required_providers {
    yandex = { source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13" /*Многострочный комментарий.
 Требуемая версия terraform */
}

#Секретики хардкодить нельзя никогда! Используем переменные, хоть мы их еще и не проходили!
provider "yandex" {
    token     = var.token
    cloud_id  = var.cloud_id
    folder_id = var.folder_id
    zone      = "ru-central1-a"
 }

#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "example" {
  name        = "netology-develop-platform-web"
  platform_id = "standard-v1"

  resources {
    cores  = 2, memory = 1, core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = 5
    }
  }

  scheduling_policy { preemptible = true }

  network_interface { subnet_id = yandex_vpc_subnet.develop.id }

 
  metadata = {
    serial-port-enable = 1
    #ssh-keygen -t ed25519  Забудьте уже про rsa ключи!!
    # ubuntu - дефолтный пользователь в ubuntu :)
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2HAglj0Yhh5Qw0ybXoDqaIRkRzZaFTgjW2p69W1X6f " 
  }
 
}
