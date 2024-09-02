###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCpYiAOHRWfQngzfWfpjq8tIe+Czk08aER7ytsEgj/Dn9rSN1c32dSBp55UIJOHE9Sc6EHmIe/1FPqEzR1CYzcqIA1nk4DuBgtCwwEbUAqRBHQjKGAyp7n2Mtiyv82X5M12NDB6v2iHf47vEakFRK4zxAWU+yw1C8bvkIKTG5LTGmqRJy+rZmQRuzhoA+UAyg2CRnrosFRcu3sa/GV/atsNCv838i+HoPhTiPyRPA9rWxQr1fTVmqVWaswMylOBV1jvsHzICvdL71QIUkvi2Cq798/Zsi8tP6BrsB0snnIMuXAwjNPWaqIHU/JbSsNLSbc+sFSpUw1TQhsd6S2mr6Fz7xV356XBhL1JfEdPty+29O5x/tnSp28AtO4CAscK+6ea2arFjDiurhlGz1AUu2xALT5DbiiHouWIjdcnT+CLcMy6V0Nod2cDZ3apDb54IEleMFllYLe8jbbg+XUklQqqWEy0wN2WsHgo9kQG6uyUKbJrPVd53O5Gik/BnOWtSU="
  description = "ssh-keygen -t ed25519"
}
