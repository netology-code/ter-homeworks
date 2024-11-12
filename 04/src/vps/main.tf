resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# закончил тут создавать две вм, пока одна
resource "yandex_compute_instance" "first_vm" {
  name              = var.storage_vm_name
  hostname          = var.storage_vm_name
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
  dynamic "secondary_disk" {
    for_each        = yandex_compute_disk.hdd[*].id
    content {
      disk_id       = secondary_disk.value
    }
  }
  scheduling_policy {
    preemptible     = var.vm_web_scheduling_policy
  }
  network_interface {
    subnet_id           = yandex_vpc_subnet.develop.id
    security_group_ids  = [yandex_vpc_security_group.example.id]
    nat                 = var.vm_web_network_interface
  }
  metadata = {
    serial-port-enable  = var.serial-port
    ssh-keys            = var.ssh-key
  }
}