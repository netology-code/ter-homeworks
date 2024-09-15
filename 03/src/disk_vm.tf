resource "yandex_compute_disk" "volume" {
    count = 3

    name = "disk-${count.index + 1}"
    size = 1 # in GB 
}


resource "yandex_compute_instance" "vms-web-with-volume" {
  name        = "web-3"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.volume
    
    content {
      disk_id = secondary_disk.value.id
    }
  }

  metadata = {
    ssh-keys = local.ssh_pub_key
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = true
  }
}