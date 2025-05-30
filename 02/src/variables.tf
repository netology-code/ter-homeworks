###cloud vars

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
  default     = "net-ru-central1-a"
  description = "VPC network & subnet name"
}

variable "vpc_name_def" {
  type        = string
  default     = "net-main"
  description = "VPC network & subnet name"
}

##ssh vars

#variable "vms_ssh_root_key" {
#  type        = string
#  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvr32tDFrCTKSsMbxVR4qhjZgfZhOSNDA4upGuhmIz1eBC/u04FTIEkV/wYr+etL02VYhUqyVZfGZ6okz0bQauegG7KDe/lJtdsox8abYQvSi8MzQnTL0jg5ug+8tj2nVJw8Dj84Q4/v5glIIxWjsiukizgSR4zEijGbre42BAdL95CB9mhxYksDuV7ygf7fQk4m6anirqtQsShyEcGBTDuc9EbJrhfQzmGWTwwm7YK7B3VXXUZD18kcg8xir8gNNck9QqfYifZokXDYD107u6sGjDFjyN3cXGvdoK8HMrCo+uUcB989QA1I35932kiayIVfAZStsvMbmOA1+6Kgw6Q== rsa 2048-20250512"
#  description = "ssh-keygen -t ed25519"
#}

