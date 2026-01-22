#TODO: combine password, bcrypt, servername

#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2404-lts" {
  family = "ubuntu-2404-lts-oslogin"
}


variable "env" {
  type    = string
  default = "production" #создавать ли бастион
}

variable "external_acess_bastion" {
  type    = bool
  default = true #false true создавать ли бастион
}

#создаем/не создаем бастион
resource "yandex_compute_instance" "bastion" {
  count = alltrue([var.env == "production", var.external_acess_bastion]) ? 1 : 0

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.network_interface.0.nat_ip_address #можно конечно и yandex_compute_instance.bastion["network_interface"][0]["nat_ip_address"] но не нужно!
    private_key = file("~/.ssh/id_ed25519")
    timeout     = "120s"
  }
  provisioner "file" {
    source      = "./scripts"
    destination = "/tmp"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts/script.sh",
      "/tmp/scripts/script.sh"
    ]
  }

  name        = "bastion" #Имя ВМ в облачной консоли
  hostname    = "bastion" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts.image_id
      type     = "network-hdd"
      size     = 15
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}






#создаем 2 идентичные ВМ во внутренней или внешней сети в зависимости от бастиона
resource "yandex_compute_instance" "example" {
  depends_on = [yandex_compute_instance.bastion]

  count = 2

  name        = "netology-develop-platform-web-${count.index}" #Имя ВМ в облачной консоли
  hostname    = "netology-develop-platform-web-${count.index}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2404-lts.image_id
      type     = "network-hdd"
      size     = 15
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = length(yandex_compute_instance.bastion) > 0 ? false : true
  }
  allow_stopping_for_update = true
}


output "vms" {
  value = {
    bastion = length(yandex_compute_instance.bastion) > 0 ? yandex_compute_instance.bastion.0.network_interface.0.nat_ip_address : null
  }
}
