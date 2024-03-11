data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "web" {
  count = 2
  name  = "${local.vm_web_name}-${count.index+1}"
  platform_id = var.default_resources.platform

  resources {
    cores = var.default_resources.resources.cores
    memory = var.default_resources.resources.memory
    core_fraction  = var.default_resources.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = var.default_resources.disk_type
      size = var.default_resources.resources.disk_size
    }
  }

  metadata = local.ssh_settings
  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  allow_stopping_for_update = true
}