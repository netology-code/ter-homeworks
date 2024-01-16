resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}



resource "yandex_vpc_network" "db" {
  name = var.vpc_name2
}
resource "yandex_vpc_subnet" "db" {
  name           = var.vpc_name2
  zone           = var.default_zone2
  network_id     = yandex_vpc_network.db.id
  v4_cidr_blocks = var.default_cidr2
}



data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image #family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "platform" {
  name        = local.web                       #var.vm_web_resource[0].instance_name #"netology-develop-platform-web"
  platform_id = var.vm_web_resource[0].platform #"standard-v1"
  resources {
    cores         = var.vm_web_resource[0].instance_cores         #2
    memory        = var.vm_web_resource[0].instance_memory        #1
    core_fraction = var.vm_web_resource[0].instance_core_fraction #5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_resource[0].preemptible #true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_resource[0].public_ip #true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}


data "yandex_compute_image" "db" {
  family = var.vm_db_image
}
resource "yandex_compute_instance" "platform_db" {
  name        = local.db #var.vm_db_resource[0].instance_name
  platform_id = var.vm_db_resource[0].platform

  zone = "ru-central1-b"
  resources {
    cores         = var.vm_db_resource[0].instance_cores
    memory        = var.vm_db_resource[0].instance_memory
    core_fraction = var.vm_db_resource[0].instance_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.db.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_resource[0].preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = var.vm_db_resource[0].public_ip
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}

