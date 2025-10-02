resource "yandex_compute_instance" "db" {
    for_each = var.vm_db_configs

    name = each.value.name
    platform_id = each.value.platform_id
    zone = var.default_zone

    resources {
        cores = each.value.cores
        memory = each.value.memory
        core_fraction = each.value.core_fraction
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            size       = each.value.disk_size
        }
    }

    scheduling_policy {
        preemptible = each.value.scheduling_policy.preemptible
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat = true
        security_group_ids = [yandex_vpc_security_group.example.id]
    }

    metadata = local.metadata
}