
resource "yandex_compute_disk" "drives" {
  count = var.number_of_drives
  name  = "drive-${count.index + 1}"
  zone  = var.default_zone
  size  = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_resource[0].public_ip
  }

  scheduling_policy {
    preemptible = var.vm_resource[0].preemptible
  }


  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.drives

    content {
      disk_id     = secondary_disk.value.id # Use the id attribute of the yandex_compute_disk resource
      device_name = "secondary-disk-${secondary_disk.key + 1}"
    }
  }
  metadata = var.metadata
}

