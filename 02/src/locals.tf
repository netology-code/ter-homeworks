locals {
  vm_web_name = "${var.vpc_name}-web-${var.default_zone}"
  vm_db_name  = "${var.vpc_name}-db-${var.vm_db_zone}"
}

