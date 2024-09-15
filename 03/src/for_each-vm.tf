resource "yandex_compute_instance" "vms-db" {
    for_each = var.vms_db

    name        = each.value.name
    platform_id = each.value.platform_id
    
    resources {
        cores         = each.value.resources.core
        memory        = each.value.resources.memory
        core_fraction = each.value.resources.core_fraction
    }

    boot_disk {
        initialize_params {
        image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
        type     = each.value.boot_disk.type
        size     = each.value.boot_disk.size
        }
    }

    metadata = {
        ssh-keys = local.ssh_key
    }

    scheduling_policy { 
        preemptible = each.value.scheduling_policy.preemptible
        }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat = each.value.network_interface.nat
    }
}