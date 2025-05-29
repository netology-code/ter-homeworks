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
  family = "${var.vm_web_ubuntu-2004-lts}" 
#  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "platform" {
  name        = "${var.vm_web_netology-develop-platform-web}"
  #name        = "netology-develop-platform-web"
  platform_id = "${var.vm_web_standard-v3}"
  #platform_id = "standard-v3"
  resources {
    cores         = "${var.vm_web_cores}"
  #  cores         = 2
    memory        = "${var.vm_web_memory}"
  #  memory        = 1
    core_fraction = "${var.vm_web_core_fraction}"
  #  core_fraction = 20
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
