###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}


variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "nat_route_table_name" {
  type        = string
  default     = "route-table"
  description = "nat route table name"
}

variable "nat_gateway_name" {
  type        = string
  default     = "nat-gateway"
  description = "nat gateway name"
}

###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   description = "ssh-keygen -t ed25519"
# }

variable vms_resources  {
  description = "resources for VMs"
  default = {
    web = {
      cores=2
      memory=1
      core_fraction=5
    }
    db = {
      cores=2
      memory=2
      core_fraction=20
    }
  }

}

variable "vms_metadata" {
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdYmU9HIi9D5Ca76K2FhkgXilzCCBx+JEDgeCpQjjP2 decimal@DESKTOP-LLH62I7"
  }
}

variable "test" {
  type = list(map(list(string)))
}
