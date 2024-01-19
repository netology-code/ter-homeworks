resource "yandex_compute_disk" "default" {
  count = 3
  name     = "${var.task_3.vm.disk.disk_name}-${count.index + 1}"
  type     = var.task_3.vm.disk.disk_type
  zone     = var.task_3.vm.disk.disk_zone
  image_id = var.task_3.vm.disk.disk_image_id
  size     = var.task_3.vm.disk.disk_size
}

resource "yandex_compute_instance" "task_3" {
  name        = var.task_3.vm.instance_name
  platform_id = var.task_3.vm.instance_platform_id

  zone = var.task_3.vm.instance_zone

  resources {
    cores         = var.task_3.vm.instance_cores
    memory        = var.task_3.vm.instance_memory
    core_fraction = var.task_3.vm.instance_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.task_3.vm.instance_preemtable
  }


  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.task_3.vm.instance_network_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.default
    content {
      device_name = "${var.task_3.vm.disk.disk_name}-${secondary_disk.value.name}"
      disk_id = secondary_disk.value.id
    }
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = local.ssh_public_key
  }

  depends_on = [yandex_compute_instance.db]
}