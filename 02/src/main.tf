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
  name        = var.vm_web_yandex_compute_instance_name
  hostname    = var.vm_web_yandex_compute_instance_name
  platform_id = var.vm_web_yandex_compute_instance_platform_id
  zone        = var.default_zone
  resources {
    cores         = var.vm_web_resources.cores
    memory        = var.vm_web_resources.memory
    core_fraction = var.vm_web_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.vm_web_initialize_params.type
      size     = var.vm_web_initialize_params.size
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_scheduling_policy
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_network_interface
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
