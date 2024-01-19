resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

#Resources sub_network without nat
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_yandex_compute_image
}

# WEB
resource "yandex_compute_instance" "web" {
  count       = 2
  name        = "web-${count.index + 1}"
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
