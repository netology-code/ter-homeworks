resource "yandex_compute_instance" "vm" {

  depends_on = [yandex_compute_instance.web]

  for_each = {
    0 = "main"
    1 = "replica"
  }

  dynamic "resources" {
    for_each = var.resources_list
    content {
      cores         = lookup(resources.value, "cpu", null)
      memory        = lookup(resources.value, "ram", null)
      core_fraction = 5

    }

  }
  name = "vm-${each.value}"

  platform_id = var.vm_platforms


  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = local.ssh_id_rsa
  } 
  

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}