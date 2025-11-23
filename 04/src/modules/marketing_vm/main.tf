variable "subnet_id" {
  type        = string
  description = "Subnet ID for the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
}

variable "zone" {
  type        = string
  description = "Availability zone"
  default     = "ru-central1-a"
}

resource "yandex_compute_instance" "marketing_vm" {
  name        = "marketing-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 22.04
      size     = 20
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

output "internal_ip" {
  value = yandex_compute_instance.marketing_vm.network_interface.0.ip_address
}

output "external_ip" {
  value = yandex_compute_instance.marketing_vm.network_interface.0.nat_ip_address
}

output "name" {
  value = yandex_compute_instance.marketing_vm.name
}
