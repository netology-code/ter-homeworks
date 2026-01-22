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
  name        = "${local.name}-web"
  platform_id = var.vm_web_yandex_compute_instance_platform_id
  zone        = var.default_zone-a
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
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
    serial-port-enable = var.metadata.vm.serial-port-enable
    ssh-keys           = var.metadata.vm.ssh-keys
  }
}

resource "yandex_compute_instance" "platform-db" {
  name        = "${local.name}-db"
  platform_id = var.vm_db_yandex_compute_instance_platform_id
  zone        = var.default_zone-b
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
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
    serial-port-enable = var.metadata.vm.serial-port-enable
    ssh-keys           = var.metadata.vm.ssh-keys
  }
}
