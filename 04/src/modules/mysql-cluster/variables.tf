variable "cluster_id" {
  type        = string
  description = "ID of the existing MySQL cluster"
}

variable "database_name" {
  type        = string
  description = "Name of the database to create"
}

variable "username" {
  type        = string
  description = "Name of the user to create"
}

variable "password" {
  type        = string
  description = "Password for the user"
  sensitive   = true
}

variable "permissions" {
  type = list(object({
    database_name = string
    roles         = list(string)
  }))
  description = "List of database permissions for the user"
  default = [{
    database_name = "default_db"
    roles         = ["ALL"]
  }]
}

variable "connection_limit" {
  type        = number
  description = "Maximum number of connections for the user"
  default     = 10
}

variable "global_permissions" {
  type        = list(string)
  description = "Global permissions for the user"
  default     = []
}
