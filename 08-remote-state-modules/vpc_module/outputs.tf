output "network_id" {
  description = "ID of the created VPC network"
  value       = yandex_vpc_network.main.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = yandex_vpc_subnet.main.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = yandex_vpc_security_group.main.id
}

output "subnet_cidr" {
  description = "CIDR block of the subnet"
  value       = yandex_vpc_subnet.main.v4_cidr_blocks[0]
}

output "zone" {
  description = "Zone where resources are created"
  value       = yandex_vpc_subnet.main.zone
}

output "vpc_summary" {
  description = "Summary of VPC resources"
  value       = <<EOT
VPC Module Created Successfully!

Network:
- Name: ${yandex_vpc_network.main.name}
- ID: ${yandex_vpc_network.main.id}

Subnet:
- Name: ${yandex_vpc_subnet.main.name}
- ID: ${yandex_vpc_subnet.main.id}
- Zone: ${yandex_vpc_subnet.main.zone}
- CIDR: ${yandex_vpc_subnet.main.v4_cidr_blocks[0]}

Security Group:
- Name: ${yandex_vpc_security_group.main.name}
- ID: ${yandex_vpc_security_group.main.id}

State stored in S3: vpc/terraform.tfstate
EOT
}
