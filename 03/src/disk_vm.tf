
resource "yandex_compute_disk" "disk" {

  count = 3
  name     = "disk0${count.index+1}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
 # disk_id = yandex_compute_disk.disk.id
 # image_id = "yandex_compute_disk.disk.${count.index+1}"
 }



resource "yandex_compute_instance" "storage" {
  name        = var.storage_disk_vm
  hostname    = var.storage_disk_vm
  platform_id = var.platform_id
    resources {
    cores         = var.cores_disk_vm
    memory        = var.memory_disk_vm
    core_fraction = var.core_fraction_disk_vm
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = var.boot_disk_disk_vm
    }
  }
#     secondary_disk {
#  #         count = 3
#     disk_id = yandex_compute_disk.disk.di
# #    count = 3
# #    image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
# #    name = disk03
#  #   disk_id = "disk03"
#     }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
        disk_id = secondary_disk.value.id
    }
  }



  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [
    yandex_vpc_security_group.example.id 
    ]
   }

  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
  }
}