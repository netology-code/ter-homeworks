# db
resource "yandex_compute_instance" "db" {
  for_each = { for idx, vm in var.each_vm : idx => vm }
  name        = each.value.instance_name
  platform_id = each.value.instance_platform_id

  zone = each.value.instance_zone

  resources {
    cores         = each.value.instance_cores
    memory        = each.value.instance_memory
    core_fraction = each.value.instance_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = each.value.instance_preemtable
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value.instance_network_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = local.ssh_public_key
  }

}
