resource "yandex_compute_instance" "db_vm" {
  for_each = { for vm in var.db_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = each.value.platform

  resources {
    cores  = each.value.cores
    memory = each.value.memory
  }

  boot_disk {
    initialize_params {
      size = each.value.boot_disk_size
      type = each.value.boot_disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.db_vm[0].public_ip
    # Additional network settings go here
  }

  metadata = {
    serial-port-enable = 1
    # Other metadata settings go here
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

}

