resource "yandex_compute_disk" "default" {
  count = 3
  name     = "${var.vm_and_disk_3_task.disk_name}-${count.index + 1}"
  type     = var.vm_and_disk_3_task.disk_type
  zone     = var.vm_and_disk_3_task.disk_zone
  image_id = var.vm_and_disk_3_task.disk_image_id
}

