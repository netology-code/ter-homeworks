# Создайте файл modules/marketing_vm/main.tf
resource "yandex_compute_instance" "marketing_vm" {
  name        = "marketing-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vmcue7la...qte3" # актуальный image_id
    }
  }

  network_interface {
    subnet_id = "your-subnet-id"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  labels = {
    environment = "marketing"
    owner       = "marketing-team"
  }
}
