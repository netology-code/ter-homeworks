variable "cluster_id" {
  description = "cluster id"
  type        = string
}

variable "database_name" {
  description = "database name"
  type        = string
}

variable "user_name" {
  description = "user naame"
  type        = string
}

variable "user_password" {
  description = "user password"
  type        = string
  sensitive   = true
}

variable "user_permissions" {
  description = "user permissions"
  type        = list(string)
  default     = []
}