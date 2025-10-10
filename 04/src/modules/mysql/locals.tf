locals {
  all_zones = keys(var.subnet_ids)

  selected_zones = var.HA ? slice(local.all_zones, 0, 2) : slice(local.all_zones, 0, 1)

  host_subnets = {
    for zone in local.selected_zones :
    zone => var.subnet_ids[zone]
  }
}