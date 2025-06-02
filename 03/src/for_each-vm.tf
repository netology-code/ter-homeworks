#считываем данные об образе ОС
# data "yandex_compute_image" "ubuntu-2004-lts" {
#   family = "ubuntu-2004-lts"
# }

resource "yandex_compute_instance" "root" {
#  depends_on = [yandex_compute_instance.bastion]

  count = length(var.each_vm)

  name        = "${var.each_vm[count.index].vm_name}-root"
#  name        = "vm_name" #Имя ВМ в облачной консоли
  hostname    = "${var.each_vm[count.index].vm_name}-root" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v1"
#  default_security_group_id = "enplpecm6j76s7feq4s5"  # Указываем групп безопасности  


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





