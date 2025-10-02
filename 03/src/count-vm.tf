data "yandex_compute_image" "ubuntu" {
    family = var.vm_image_family
}

resource "yandex_compute_instance" "web" {

    depends_on = [yandex_compute_instance.db]

    count = 2

    name = "web-${count.index + 1}"
    hostname = "web-${count.index + 1}"
    platform_id = var.vm_web_configs.platform_id
    zone = var.default_zone

    resources {
        cores = var.vm_web_configs.cores
        memory = var.vm_web_configs.memory
        core_fraction = var.vm_web_configs.core_fraction
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            size       = var.vm_web_configs.disk_size
        }
    }

    scheduling_policy {
        preemptible = var.vm_web_configs.scheduling_policy.preemptible
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat = true
        security_group_ids = [yandex_vpc_security_group.example.id]
    }

    metadata = local.metadata


}