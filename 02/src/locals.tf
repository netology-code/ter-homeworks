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
    cores = number
    memory = number
    core_fraction = number
  }))
default = {
    "resources-web1" = {
    cores = 2
    memory = 1
    core_fraction = 20
    },
    "resources-db1" =  {
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

variable "ssh" {
  type = map(object({
    key = string
  }))
  default = {
    "ssh-all" = {
      key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvr32tDFrCTKSsMbxVR4qhjZgfZhOSNDA4upGuhmIz1eBC/u04FTIEkV/wYr+etL02VYhUqyVZfGZ6okz0bQauegG7KDe/lJtdsox8abYQvSi8MzQnTL0jg5ug+8tj2nVJw8Dj84Q4/v5glIIxWjsiukizgSR4zEijGbre42BAdL95CB9mhxYksDuV7ygf7fQk4m6anirqtQsShyEcGBTDuc9EbJrhfQzmGWTwwm7YK7B3VXXUZD18kcg8xir8gNNck9QqfYifZokXDYD107u6sGjDFjyN3cXGvdoK8HMrCo+uUcB989QA1I35932kiayIVfAZStsvMbmOA1+6Kgw6Q== rsa 2048-20250512"
    },
  }
}

locals {
ssh-key = "ubuntu:${var.ssh.ssh-all.key}"
}