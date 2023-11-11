resource "yandex_compute_disk" "storage" {
  count = 3
  name  = "${var.storage.name}-${count.index}"
  type  = var.storage.type
  zone  = var.default_zone
  size  = var.storage.size
}

resource "yandex_compute_instance" "mount-storage" {

  depends_on = [ yandex_compute_disk.storage ]

  name        = "mount-storage-vm"
  platform_id = var.vm_platforms

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

  dynamic "secondary_disk" {
    for_each = toset(yandex_compute_disk.storage[*].id)
    content {
      disk_id = secondary_disk.key
    }
  }

scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.ssh_id_rsa
  } 
}