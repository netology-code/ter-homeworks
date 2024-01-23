
resource "yandex_compute_instance" "db_vm" {
  for_each = { for vm in var.db_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = each.value.platform

  resources {
    cores         = each.value.cores
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.db_vm[0].public_ip

  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  /*
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
*/

  metadata = var.metadata

}
