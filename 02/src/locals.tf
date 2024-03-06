locals {

  vm_web_name = "${var.company}-${var.environment}-${var.project_name}-${var.vm_role[0]}"
  vm_db_name  = "${var.company}-${var.environment}-${var.project_name}-${var.vm_role[1]}"
}