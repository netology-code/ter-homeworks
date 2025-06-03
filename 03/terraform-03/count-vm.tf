#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "example" {
  depends_on = [yandex_compute_instance.root]

  count = 2

  name        = "web-${count.index+1}" #Имя ВМ в облачной консоли
  hostname    = "web-${count.index+1}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = var.platform_id
#  default_security_group_id = "enplpecm6j76s7feq4s5"  # Указываем групп безопасности  


  resources {
    cores         = var.cores_count_vm
    memory        = var.memory_count_vm
    core_fraction = var.core_fraction_count_vm
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = var.boot_disk_count_vm
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [
    yandex_vpc_security_group.example.id 
    ]
   }
  allow_stopping_for_update = true
}

