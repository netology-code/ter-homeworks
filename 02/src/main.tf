
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#resource "yandex_vpc_network" "develop-2" {
#  name = var.vpc_name_2
#}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

#resource "yandex_vpc_subnet" "develop-2" {
#  name           = var.vpc_name_2
#  zone           = var.zone_b
#  network_id     = yandex_vpc_network.develop-2.id
#  v4_cidr_blocks = var.default_cidr
#}



data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_yandex_compute_image
}

#WEB
resource "yandex_compute_instance" "platform" {
  name        = local.web_name
  platform_id = var.vm_web_.platform_id

  zone = var.vm_web_.zone

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
    preemptible = var.vm_web_.scheduling_policy.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_.network_interface.nat
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.metadata.ssh-keys}"
  }

}

#DB
resource "yandex_compute_instance" "platform-db" {
  name        = local.db_name
  platform_id = var.vm_db_.platform_id

  zone = var.vm_db_.zone

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
    preemptible = var.vm_db_.scheduling_policy.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.nat.id
    nat       = false
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.metadata.ssh-keys}"
  }

}
