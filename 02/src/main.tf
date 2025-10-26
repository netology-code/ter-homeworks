resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Первая подсеть для первой ВМ
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Вторая подсеть для второй ВМ
resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-b"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_cidr
}

# Первая ВМ
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_full_name
  platform_id = var.vm_web_platform_id

  resources {
      cores         = var.vms_resources["web"].cores
      memory        = var.vms_resources["web"].memory
      core_fraction = var.vms_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vms_resources["web"].hdd_size
      type     = var.vms_resources["web"].hdd_type
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources["web"].preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

#  metadata = {
#    serial-port-enable = 1
#    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
#  }
  metadata = var.vms_metadata

}

# Вторая ВМ
data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image_family
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_full_name
  platform_id = var.vm_db_platform_id

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.id
      size     = var.vms_resources["db"].hdd_size
      type     = var.vms_resources["db"].hdd_type
    }
  }

  scheduling_policy {
    preemptible = var.vms_resources["db"].preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = true
  }

  zone = var.vm_db_zone

#  metadata = {
#    serial-port-enable = 1
#    ssh-keys           = "ubuntu:${var.vms_ssh_public_root_key}"
#  }

  metadata = var.vms_metadata
}

