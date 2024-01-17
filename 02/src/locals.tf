
locals {
  web           = "netology-${var.env}-${var.project}-${var.role}"
  db            = "netology-${var.env1}-${var.project1}-${var.role1}"
  web_resources = var.vms_resources["web"]
  db_resources  = var.vms_resources["db"]
}

