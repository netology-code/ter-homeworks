#TODO: combine password, bcrypt, servername

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

#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "example" {
  count = 2

  name        = "netology-develop-platform-web-${count.index}"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}



resource "random_password" "solo" {
  length = 17
#> type.random_password.solo  list(object)
}

resource "random_password" "count" {
  count    = length([ for i in yandex_compute_instance.example: i])
  length = 17
#> type(random_password.count)  list(object)
}


resource "random_password" "each" {
  for_each    = toset([for k, v in yandex_compute_instance.example : v.name ])
  length = 17
#> type(random_password.each) object(object)
}

