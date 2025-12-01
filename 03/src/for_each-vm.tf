# Локальная переменная для считывания SSH-ключа
locals {
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

# Переменная для ВМ баз данных
variable "each_vm" {
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    core_fraction = optional(number, 100)
    disk_type     = optional(string, "network-hdd")
    zone          = optional(string, "ru-central1-a")
  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 4
      ram           = 8
      disk_volume   = 50
      core_fraction = 100
      disk_type     = "network-ssd"
    },
    {
      vm_name       = "replica"
      cpu           = 2
      ram           = 4
      disk_volume   = 30
      core_fraction = 50
      disk_type     = "network-hdd"
    }
  ]
}

# Создание ВМ с помощью for_each
resource "yandex_compute_instance" "database_vm" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = "standard-v3"
  zone        = each.value.zone

  allow_stopping_for_update = true

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = "fd8fhirjb21am2sv9aud" # Ubuntu 22.04
      size     = each.value.disk_volume
      type     = each.value.disk_type
    }
  }

  network_interface {
    subnet_id          = "e9bproja629hr9doud9c" # Ваша подсеть
    nat                = true
    security_group_ids = ["enpcf56b6oforfoso9vb"] # Ваша группа безопасности
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  scheduling_policy {
    preemptible = false
  }
}
