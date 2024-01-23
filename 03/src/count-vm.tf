
resource "yandex_compute_instance" "web" {
  count = var.vm_count

  name        = "web-${count.index + 1}"
  platform_id = "standard-v1"
  depends_on  = [yandex_compute_instance.db_vm]

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
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_resource[0].public_ip
    security_group_ids = [yandex_vpc_security_group.example.id]

  }

  scheduling_policy {
    preemptible = var.vm_resource[0].preemptible
  }

  metadata = var.metadata


}
