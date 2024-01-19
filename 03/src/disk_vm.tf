resource "yandex_compute_disk" "default" {
  count = 3
  name     = "${var.task_3.vm.disk.disk_name}-${count.index + 1}"
  type     = var.task_3.vm.disk.disk_type
  zone     = var.task_3.vm.disk.disk_zone
  image_id = var.task_3.vm.disk.disk_image_id
}

