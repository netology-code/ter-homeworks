resource "yandex_compute_disk" "disk" {
  count = 3

  name = "disk-${count.index + 1}"
  size = 1
  type = "network-hdd"
  zone = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name = "storage"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat                = true
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk

    content {
      disk_id = secondary_disk.value.id
    }
  }
}
