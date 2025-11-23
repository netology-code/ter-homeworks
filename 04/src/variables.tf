variable "cluster_name" {
  type        = string
  description = "Name of the MySQL cluster"
}

variable "network_id" {
  type        = string
  description = "Network ID where the cluster will be created"
}

variable "ha" {
  type        = bool
  description = "High Availability mode (true for multi-host, false for single host)"
  default     = false
}

variable "host_count" {
  type        = number
  description = "Number of hosts in the cluster"
  default     = 2
}

variable "environment" {
  type        = string
  description = "Environment (production, staging, development)"
  default     = "production"
}

variable "mysql_version" {
  type        = string
  description = "MySQL version"
  default     = "8.0"
}

variable "resource_preset_id" {
  type        = string
  description = "Resource preset ID for hosts"
  default     = "s2.micro"
}

variable "disk_size" {
  type        = number
  description = "Disk size in GB"
  default     = 20
}

variable "disk_type_id" {
  type        = string
  description = "Disk type ID"
  default     = "network-ssd"
}

variable "zones" {
  type        = list(string)
  description = "List of availability zones for hosts"
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for hosts (must match zones)"
}

variable "username" {
  type        = string
  description = "MySQL admin username"
  default     = "admin"
}

variable "password" {
  type        = string
  description = "MySQL admin password"
  sensitive   = true
}
