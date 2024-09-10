locals {
    web_name = "${var.vpc_name}-${var.vms["web"]["name"]}"
    db_name = "${var.subnet_b["name"]}-${var.vms["db"]["name"]}"
}