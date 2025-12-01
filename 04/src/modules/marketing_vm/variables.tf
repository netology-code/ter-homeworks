variable "security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with the instance."
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
}

variable "zone" {
  type        = string
  description = "Availability zone"
  default     = "ru-central1-a"
}
