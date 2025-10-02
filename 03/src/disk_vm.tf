resource "yandex_compute_disk" "storage_disks" {
    count = 3
    name = "storage-disk-${count.index}"
    type = var.storage_disks_configs.type
    zone = var.default_zone
    size = var.storage_disks_configs.disk_size
}

resource "yandex_compute_instance" "storage" {

    name = var.vm_storage_configs.name

    platform_id = var.vm_storage_configs.platform_id
    zone = var.default_zone

    resources {
        cores = var.vm_storage_configs.cores
        memory = var.vm_storage_configs.memory
        core_fraction = var.vm_storage_configs.core_fraction
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            size       = var.vm_storage_configs.disk_size
        }
    }

    dynamic "secondary_disk" {
        for_each = resource.yandex_compute_disk.storage_disks
        content {
            disk_id = secondary_disk.value.id
        }
    }

    scheduling_policy {
        preemptible = var.vm_storage_configs.scheduling_policy.preemptible
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat = true
        security_group_ids = [yandex_vpc_security_group.example.id]
    }

    metadata = local.metadata

}