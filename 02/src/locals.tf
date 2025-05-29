#variable "bad_example" { default = "${ var.env }–${ var.project }"}

variable "role" {
  type = map(object({
    name = string
    number  = number
  }))
  default = {
    "name-db1" = {
      name = "db"
      number  = 01
    },
    "name-web2" = {
      name = "web"
      number  = 02
    }
  }
}

locals {
name-db1 = "netology-develop-platform-${var.role.name-db1.name}${var.role.name-db1.number}"
name-web1 = "netology-develop-platform-${var.role.name-web2.name}${var.role.name-web2.number}"
}


variable "vms_resources"  {
  type = map(object({
#  type = list(object({
#    instance_name   = string
    cores = number
    memory = number
    core_fraction = number
  }))
default = {
    "resources-web1" = {
#    instance_name = "web1"
    cores = 2
    memory = 1
    core_fraction = 20
    },
    "resources-db1" =  {
 #   instance_name = "db1"
    cores = 2
    memory = 2
    core_fraction = 20
    }
  }
}

locals {
resources-web1 = "${var.vms_resources.resources-web1}"
resources-db1 = "${var.vms_resources.resources-db1}"
}



#locals {
#name = "${ var.env }–${ var.project }"
#test = "123"
#}

#variable "bad_example" { default = "${ var.env }–${ var.project }"}

#variable  netology-develop-platform-${ var.role }