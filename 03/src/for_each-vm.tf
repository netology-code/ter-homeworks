resource "yandex_compute_instance" "database" {
  depends_on  = [yandex_compute_instance.web ]
  for_each = {for vm in var.each_vm: vm.vm_name => vm}
  name        = each.key
  platform_id = var.default_resources.platform


  resources {
    cores  = each.value.cores
    memory = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type =  var.default_resources.disk_type
      size = each.value.disk_size
    }
  }

  metadata = local.ssh_settings

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}
~     