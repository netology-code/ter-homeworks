resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop-a" {
  name           = var.name_zone-a
  zone           = var.default_zone-a
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr-zone-a
}
resource "yandex_vpc_subnet" "develop-b" {
  name           = var.name_zone-b
  zone           = var.default_zone-b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr-zone-b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_yandex_compute_image_family
}

resource "yandex_compute_instance" "platform-web" {
  name        = var.vm_web_yandex_compute_instance_name
  platform_id = var.vm_web_yandex_compute_instance_platform_id
  zone        = var.default_zone-a
  resources {
    cores         = var.vm_web_yandex_compute_instance_resources_cores
    memory        = var.vm_web_yandex_compute_instance_resources_memory
    core_fraction = var.vm_web_yandex_compute_instance_resources_core_fraction
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
    subnet_id = yandex_vpc_subnet.develop-a.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}

resource "yandex_compute_instance" "platform-db" {
  name        = var.vm_db_yandex_compute_instance_name
  platform_id = var.vm_db_yandex_compute_instance_platform_id
  zone        = var.default_zone-b
  resources {
    cores         = var.vm_db_yandex_compute_instance_resources_cores
    memory        = var.vm_db_yandex_compute_instance_resources_memory
    core_fraction = var.vm_db_yandex_compute_instance_resources_core_fraction
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
  }
}
