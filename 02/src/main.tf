resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_yandex_compute_image_family
}

resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_yandex_compute_instance_name
  platform_id = var.vm_web_yandex_compute_instance_platform_id
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}

resource "yandex_compute_instance" "platform" {
  name        = var.vm_db_yandex_compute_instance_name
  platform_id = var.vm_db_yandex_compute_instance_platform_id
  resources {
    cores         = var.db_web_yandex_compute_instance_resources_cores
    memory        = var.db_web_yandex_compute_instance_resources_memory
    core_fraction = var.db_web_yandex_compute_instance_resources_core_fraction
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
  }
}
