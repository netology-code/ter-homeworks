variable "cluster_name" {
    description = "Mysql cluster name"
    type = string
}


variable "environment" {
    description = "environment: PRODUCTION or PRESTABLE"
    type = string
    default = "PRESTABLE"
}

variable "mysql_version" {
    description = "mysql version"
    type = string
    default = "8.0"
}

##  cluster resources 
variable "resource_preset" {
    description = "resource preset for instance"
    type = string
    default = "s2.micro"
}

variable "disk_type" {
    description = "disk type: network-ssd, network-hdd"
    default = "network-hdd"
}

variable "disk_size" {
  description = "disk size GB"
  type        = number
  default     = 10
}

##  database resources
variable "database_name" {
  description = "database name"
  type        = string
  default     = "netology_database"
}

variable "username" {
  description = "database username"
  type        = string
  default     = "db_user"
}

variable "password" {
  description = "password database username"
  type        = string
  sensitive   = true
  default     = "Net-Ter-04!"
}

variable "user_roles" {
  description = "user roles"
  type        = list(string)
  default     = ["ALL"]
}


variable "network_id" {
    description = "network id"
    type = string
}

variable "subnet_ids" {
    description = "subnet ids from vpc module"
    type = map(string)
}

variable "HA" {
    description = "hight accessibility"
    type = bool
    default = false
}

variable "zones" {
  description = "available zones"
  type = list
  default = ["ru-central1-a", "ru-central1-b"]
}

variable "hosts_count" {
  description = "hosts count"
  type = number
  default = 2
}