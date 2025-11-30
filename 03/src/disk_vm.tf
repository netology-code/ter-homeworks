# Создание 3 одинаковых виртуальных дисков
resource "yandex_compute_disk" "storage" {
  count = 3

  name = "storage-disk-${count.index}"
  type = "network-hdd"
  zone = "ru-central1-a"
  size = 1
}

# Одиночная ВМ "storage" с подключением дисков через dynamic block
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8fhirjb21am2sv9aud" # Ubuntu 22.04
      size     = 10
      type     = "network-hdd"
    }
  }

  # Dynamic block для подключения дополнительных дисков
  dynamic "secondary_disk" {
    for_each = { for idx, disk in yandex_compute_disk.storage : idx => disk.id }
    content {
      disk_id = secondary_disk.value
    }
  }

  network_interface {
    subnet_id          = "e9bproja629hr9doud9c" # Ваша подсеть
    nat                = true
    security_group_ids = ["enpcf56b6oforfoso9vb"] # Ваша группа безопасности
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = false
  }
}
