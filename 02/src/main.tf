resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = var.vpc_name-b
  zone           = var.default_zone-b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr-b
}

data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_web_ubuntu-2004-lts}" 
#  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "platform" {
  name        = "${var.vm_web_netology-develop-platform-web}"
  platform_id = "${var.vm_web_standard-v3}"
  resources {
    cores         = "${var.vm_web_cores}"
    memory        = "${var.vm_web_memory}"
    core_fraction = "${var.vm_web_core_fraction}"
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
   #ssh-keygen -t ed25519  На ed25519 переконфигурирую после сдачи ДЗ, а то половину уже сделал.
  }

}
###########

resource "yandex_compute_instance" "platform2" {
  name        = "${var.vm_db_netology-develop-platform-db}"
  platform_id = "${var.vm_db_standard-v3}"
  zone        = "ru-central1-b"   #var.default_zone-b
  resources {
    cores         = "${var.vm_db_cores}"
    memory        = "${var.vm_db_memory}"
    core_fraction = "${var.vm_db_core_fraction}"
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
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
   #ssh-keygen -t ed25519  На ed25519 переконфигурирую после сдачи ДЗ, а то половину уже сделал.
  }

}


#####