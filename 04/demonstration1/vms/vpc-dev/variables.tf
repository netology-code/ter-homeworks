
variable "zone" {
  type        = string
  default     = "ru-central1-a"
}
variable "cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "env_name" {
  type        = string
  default     = "develop"
}

# variable "cloud_id" {
#   type        = string
#  #   default     = "b1g8fa5kgacq5ib1h509"
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
# }

# variable "folder_id" {
#   type        = string
#  #   default     = "b1gtnnmljkg2pphuqpge"
#   description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
# }

# # variable "default_zone" {
# #   type        = string
# # #  default     = "ru-central1-a"
# #   description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
# # }
