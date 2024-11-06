resource "yandex_compute_instance" "web" {
  count             = 2
  name              = "web-${count.index + 1}"
  hostname          = "web-${count.index + 1}"
  platform_id       = var.vm_web_yandex_compute_instance_platform_id
  zone              = var.default_zone
  resources {
    cores           = var.vm_resources.web.cores
    memory          = var.vm_resources.web.memory
    core_fraction   = var.vm_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id      = data.yandex_compute_image.ubuntu.image_id
      type          = var.vm_resources.web.type
      size          = var.vm_resources.web.size
    }
  }
  scheduling_policy {
    preemptible     = var.vm_web_scheduling_policy
  }
  network_interface {
    subnet_id       = yandex_vpc_subnet.develop.id
    nat             = var.vm_web_network_interface
  }
  metadata = {
    serial-port-enable = var.serial-port
    ssh-keys           = var.ssh-key
  }
}