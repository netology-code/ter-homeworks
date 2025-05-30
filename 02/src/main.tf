resource "yandex_vpc_network" "develop" {
  name = var.vpc_name_def
}

resource "yandex_vpc_subnet" "develop" {
  name           = "${var.vpc_name}"
  zone           = "${var.default_zone}"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = "${var.default_cidr}"
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = "${var.vpc_name-b}"
  zone           = "${var.default_zone-b}"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = "${var.default_cidr-b}"
}

data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_web_ubuntu-2004-lts}" 
}

resource "yandex_compute_instance" "platform" {
  name        = "${local.name-web1}"
  platform_id = "${var.vm_web_standard-v3}"
    resources {
    cores         = "${local.resources-web1.cores}"
    memory        = "${local.resources-web1.memory}"
    core_fraction = "${local.resources-web1.core_fraction}"
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
        ssh-keys           = "${local.ssh-key}"
  }
}
###########

resource "yandex_compute_instance" "platform2" {
  name        = "${local.name-db1}"
  platform_id = "${var.vm_db_standard-v3}"
  zone        = "${var.default_zone-b}"   

  resources {
    cores         = "${local.resources-db1.cores}"
    memory        = "${local.resources-db1.memory}"
    core_fraction = "${local.resources-db1.core_fraction}"
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
    ssh-keys           = "${local.ssh-key}"
 #       ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
   #ssh-keygen -t ed25519  На ed25519 переконфигурирую после сдачи ДЗ, а то половину уже сделал.
  }
}