variable "public_key" {
  type    = string
  default = "<your public key here!!>"
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
  { webservers = { server1="1.1.1.1", server2="2.2.2.2" }}
  )
  filename = "${abspath(path.module)}/hosts.cfg"
}


resource "null_resource" "web_hosts_provision" {
#Ждем создания инстанса
depends_on = [yandex_compute_instance.example]

#Добавление ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "echo '${var.private_key}' | ssh-add -"
  }
#Создание inventory из файла шаблона
 provisioner "local-exec" {
    command = <<-EOA
    echo "${templatefile("ansible_inventory.yml.tftpl", 
   { hosts = yandex_compute_instance.web[*] })}" > hosts.yml
    EOA
  }
#Даем ВМ время на первый запуск. Лучше выполнить через wait_for port 22 на стороне ansible
 provisioner "local-exec" {
    command = <<-EOA
    echo "${templatefile("ansible_inventory.yml.tftpl", 
   { hosts = yandex_compute_instance.web[*] })}" > hosts.yml
    EOA
  }
#Запуск ansible-playbook
  provisioner "local-exec" {                  
    command  = "ansible-playbook -i hosts.yml test.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    interpreter = ["bash"]
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
    triggers = {  
      always_run         = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
      ssh_public_key     = jsonencode(var.vault_token) # при изменении переменной
    }
  }
}





terraform {
  required_providers {
    yandex = { source = "yandex-cloud/yandex"
  }}
  required_version = ">= 0.13"
}

#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.example.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "example" {
  name        = "netology-develop-platform-web-{count.index}"
  platform_id = "standard-v1"
  
  count = 2

  resources {
    cores  = 2, memory = 1, core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = 5
  }
   
  metadata = {
    ssh-keys = "ubuntu:${var.public_key}"
  }
      
  }

  scheduling_policy { preemptible = true }

  network_interface { subnet_id = yandex_vpc_subnet.example.id }

}
