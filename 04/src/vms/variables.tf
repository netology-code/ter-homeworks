###cloud vars

variable "public_keys" {
  type        = list(string)
  description = "List of SSH public keys"
}

#variable "token" {
#  type = string
#}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

