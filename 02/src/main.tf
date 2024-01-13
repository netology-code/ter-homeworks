resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#resource "yandex_vpc_network" "develop-2" {
  #name = var.vpc_name_2
#}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-2" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}



data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_yandex_compute_image
}

#WEB
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_.name
  platform_id = var.vm_web_.platform_id

  zone = var.vm_web_.zone

  resources {
    cores         = var.vm_web_.resources.cores
    memory        = var.vm_web_.resources.memory
    core_fraction = var.vm_web_.resources.core_fraction
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
    serial-port-enable = var.vm_web_.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }

}

#DB
resource "yandex_compute_instance" "platform-db" {
  name        = var.vm_db_.name
  platform_id = var.vm_db_.platform_id

  zone = var.vm_db_.zone

  resources {
    cores         = var.vm_db_.resources.cores
    memory        = var.vm_db_.resources.memory
    core_fraction = var.vm_db_.resources.core_fraction
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
    subnet_id = yandex_vpc_subnet.develop-2.id
    nat       = var.vm_db_.network_interface.nat
  }

  metadata = {
    serial-port-enable = var.vm_db_.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }

}
