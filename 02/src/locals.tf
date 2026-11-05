locals {
  vm_web_name = "${var.project_prefix}-${var.vpc_name}-platform-web"
  vm_db_name  = "${var.project_prefix}-${var.vpc_name}-platform-db"
}
