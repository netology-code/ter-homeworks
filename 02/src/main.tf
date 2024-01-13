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
  family = var.vm_web_yandex_compute_image
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web.name
  platform_id = var.vm_web.platform_id

  zone = var.vm_web.zone

  resources {
    cores         = var.vm_web.resources.cores
    memory        = var.vm_web.resources.memory
    core_fraction = var.vm_web.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web.scheduling_policy.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web.network_interface.nat
  }

  metadata = {
    serial-port-enable = var.vm_web.metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
  }

}
