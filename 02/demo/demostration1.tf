#создаем облачную сеть develop
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем облачную сеть prod
resource "yandex_vpc_network" "prod" {
  name = "prod"
}

#создаем облачную подсеть zone A prod
resource "yandex_vpc_subnet" "prod-a" {
  name           = "prod-ru-central1-a"
  zone           = "ru-central1-a" #Это очень важно  при создании ресурса в зоне отличной от Зоны по-умолчанию("ru-central1-a")! 
  network_id     = yandex_vpc_network.prod.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}



#создаем облачную подсеть zone A
resource "yandex_vpc_subnet" "develop-a" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a" #Это очень важно  при создании ресурса в зоне отличной от Зоны по-умолчанию("ru-central1-a")! 
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

#создаем облачную подсеть zone B
resource "yandex_vpc_subnet" "develop-b" {
  name           = "develop-ru-central1-b"
  zone           = "ru-central1-b" #Это очень важно  при создании ресурса в зоне отличной от Зоны по-умолчанию("ru-central1-a")! 
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}


#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "example-a" {
  name        = "netology-develop-platform-web-a"
  platform_id = "standard-v1"

  zone = "ru-central1-a" #Это очень важно  при создании ресурса в зоне отличной от Зоны по-умолчанию("ru-central1-a")! 

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-a.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    #ssh-keygen -t ed25519  Забудьте уже про rsa ключи!!
    # ubuntu - дефолтный пользователь в ubuntu :)
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiVcfW8Wa/DxbBNzmQcwn7hJOj7ji9eoTpFakVnY/AI webinar"
  }

}

resource "yandex_compute_instance" "example-b" {
  name        = "netology-develop-platform-web-b"
  platform_id = "standard-v1"

  zone = "ru-central1-b" #Это очень важно  при создании ресурса в зоне отличной от Зоны по-умолчанию("ru-central1-a")! 
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }


  metadata = {
    serial-port-enable = 1
    #ssh-keygen -t ed25519  Забудьте уже про rsa ключи!!
    # ubuntu - дефолтный пользователь в ubuntu :)
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiVcfW8Wa/DxbBNzmQcwn7hJOj7ji9eoTpFakVnY/AI webinar"
  }

}


resource "yandex_compute_instance" "prod-example-a" {
  name        = "netology-prod-platform-web-a"
  platform_id = "standard-v1"

  zone = "ru-central1-a" #Это очень важно  при создании ресурса в зоне отличной от Зоны по-умолчанию("ru-central1-a")! 

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.prod-a.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    #ssh-keygen -t ed25519  Забудьте уже про rsa ключи!!
    # ubuntu - дефолтный пользователь в ubuntu :)
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiVcfW8Wa/DxbBNzmQcwn7hJOj7ji9eoTpFakVnY/AI webinar"
  }

}

#https://console.cloud.yandex.ru/folders/b1gfu61oc15cb99nqmfe/vpc/network-map/current-folder
output "test" {

  value = [
    { dev1 = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.example-a.network_interface[0].nat_ip_address}", yandex_compute_instance.example-a.network_interface[0].ip_address] },
    { dev2 = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.example-b.network_interface[0].nat_ip_address}", yandex_compute_instance.example-b.network_interface[0].ip_address] },
    { prod1 = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.prod-example-a.network_interface[0].nat_ip_address}", yandex_compute_instance.prod-example-a.network_interface[0].ip_address] }

  ]
}

# terraform output > test.txt
