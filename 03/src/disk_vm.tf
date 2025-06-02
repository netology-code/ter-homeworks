
resource "yandex_compute_disk" "disk" {

  count = 3
  name     = "disk0${count.index+1}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
 # disk_id = yandex_compute_disk.disk.id
 # image_id = "yandex_compute_disk.disk.${count.index+1}"
 }



resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
    resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 5
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