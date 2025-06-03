resource "yandex_compute_instance" "root" {

  count = length(var.each_vm)

  name        = "${var.each_vm[count.index].vm_name}"
  hostname    = "${var.each_vm[count.index].vm_name}" 
  platform_id = var.platform_id

  resources {
    cores         = "${var.each_vm[count.index].cpu}"
    memory        = "${var.each_vm[count.index].ram}"
    core_fraction = "${var.each_vm[count.index].core_fraction}"
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type     = "network-hdd"
      size     = "${var.each_vm[count.index].disk_volume}"
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





