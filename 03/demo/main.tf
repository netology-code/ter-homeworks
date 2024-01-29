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
data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

#создаем 2 идентичные ВМ
resource "yandex_compute_instance" "example" {
  count = 2

  name        = "netology-develop-platform-web-${count.index}"
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


resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",

  { webservers = yandex_compute_instance.example })

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "local_file" "hosts_for" {
  content =  <<-EOT
  %{if length(yandex_compute_instance.example) > 0}
  [webservers]
  %{endif}
  %{for i in yandex_compute_instance.example }
  ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]}
  %{endfor}
  EOT
  filename = "${abspath(path.module)}/for.cfg"

}

resource "random_password" "solo" {
  length = 17
#> type.random_password.solo  list(object)
}

resource "random_password" "count" {
  count    = length([ for i in yandex_compute_instance.example: i])
  length = 17
#> type(random_password.count)  list(object)
}


resource "random_password" "each" {
  for_each    = toset([for k, v in yandex_compute_instance.example : v.name ])
  length = 17
#> type(random_password.each) object(object)
}

variable "web_provision" {
  type    = bool
  default = true
  description="ansible provision switch variable"
}


resource "null_resource" "web_hosts_provision" {
  count = var.web_provision == true ? 1 : 0 #var.web_provision ? 1 : 0
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.example]

  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }

  #Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
  # # В случае использования cloud-init может потребоваться еще больше времени
  # provisioner "local-exec" {
  #   command = "sleep 60"
  # }

  #Запуск ansible-playbook
  provisioner "local-exec" {
    # without secrets
    # command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    
    #secrets pass
    #> nonsensitive(jsonencode( {for k,v in random_password.each: k=>v.result}))
    /*
      "{\"netology-develop-platform-web-0\":\"u(qzeC#nKjp*wTOY\",\"netology-develop-platform-web-1\":\"=pA12\\u0026C2eCl[Oe$9\"}"
    */
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml --extra-vars '{\"secrets\": ${jsonencode( {for k,v in random_password.each: k=>v.result})} }'"

    # for complex cases instead  --extra-vars "key=value", use --extra-vars "@some_file.json"

    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    # always_run        = "${timestamp()}"                         #всегда т.к. дата и время постоянно изменяются
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    ssh_public_key    = var.public_key                           # при изменении переменной with ssh
    template_rendered = "${local_file.hosts_templatefile.content}" #при изменении inventory-template
    password_change = jsonencode( {for k,v in random_password.each: k=>v.result})

  }

}
