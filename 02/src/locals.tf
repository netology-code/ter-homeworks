locals {

  test = [
    {
      "vm-web" = "netology-${var.vpc_name}-${var.vm_web_yandex_compute_instance_platform_id}-${var.vm_web_zone}-web"
    },
    {
      "vm-db" = "netology-${var.vpc_name}-${var.vm_db_yandex_compute_instance_platform_id}-${var.vm_db_zone}-db"
    },
  ]
}
