locals {
  vm_web_full_name = "${var.vpc_name}-${var.environment}-platform-${var.role_web}"
  vm_db_full_name  = "${var.vpc_name}-${var.environment}-platform-${var.role_db}"
}
