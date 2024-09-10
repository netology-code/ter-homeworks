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
  family = var.vm_web_platform_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.web_name
  platform_id = var.vms["web"]["platform_id"]
  
  resources {
    cores         = var.vms["web"].resources["core"]
    memory        = var.vms["web"].resources["memory"]
    core_fraction = var.vms["web"].resources["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms["web"].scheduling_policy["preemptible"]
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms["web"].network_interface["nat"]
  }

  metadata = {
    serial-port-enable = var.vms["web"].metadata["serial-port-enable"]
    ssh-keys           = "${var.vms["web"].metadata["ssh-user"]}:${var.vms_ssh_root_key}"
  }

}
