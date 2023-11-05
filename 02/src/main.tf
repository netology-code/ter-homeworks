resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  #family = "ubuntu-2004-lts"
  family = var.vm_family
}
resource "yandex_compute_instance" "vm-1" {
  #name        = "netology-develop-platform-web"
  name = local.name_web
  #platform_id = "standard-v1"
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.vm_web_resources["cores"]
    memory        = var.vm_web_resources["memory"]
    core_fraction = var.vm_web_resources["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.common_metadata

}

resource "yandex_compute_instance" "vm-2" {
  name = local.name_db
  platform_id = var.vm_db_platform_id

    resources {
    cores         = var.vm_db_resources["cores"]
    memory        = var.vm_db_resources["memory"]
    core_fraction = var.vm_db_resources["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.common_metadata

}
