variable "default_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "subnet_b" {
    type = object({
      name = string
      v4_cidr_blocks = list(string)
    })
    default = {
      name = "develop-b"
      v4_cidr_blocks = ["10.0.2.0/24"]
    }
}

/*variable "vm_db_platform" {
  type    = object({
    name = string
    platform_id = string
    resources = object({
      core = number
      memory = number
      core_fraction = number 
    })
    scheduling_policy = object({
      preemptible = bool
    })
    network_interface = object({
      nat = bool
    })
    metadata = object({
      serial-port-enable = number
      ssh-user = string
    })
    true_flg = bool
  })
  default = {
    name = "platform-db"
    platform_id = "standard-v1"
    resources = {
      core=2
      memory=2
      core_fraction=20
    }
    scheduling_policy = {
      preemptible = true
    }
    network_interface = {
      nat = true
    }
    metadata = {
      serial-port-enable = 1
      ssh-user  = "ubuntu"
    }
    true_flg = true 
  } 
}*/

resource "yandex_vpc_subnet" "develop_b" {
  name           = var.subnet_b.name
  zone           = var.default_zone_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.subnet_b.v4_cidr_blocks
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.db_name
  platform_id = var.vms["db"]["platform_id"]
  zone = var.default_zone_b
  
  resources {
    cores         = var.vms["db"].resources["core"]
    memory        = var.vms["db"].resources["memory"]
    core_fraction = var.vms["db"].resources["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms["db"].scheduling_policy["preemptible"]
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vms["db"].network_interface["nat"]
  }

  metadata = {
    serial-port-enable = var.vms["db"].metadata["serial-port-enable"]
    ssh-keys           = "${var.vms["db"].metadata["ssh-user"]}:${var.vms_ssh_root_key}"
  }

}