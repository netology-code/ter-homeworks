generate_hcl "providers.tf" {
  content {
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = global.terraform_version
    }

    provider "yandex" {
      cloud_id                 = global.yc_cloud_id
      folder_id                = global.yc_folder_id
      service_account_key_file = file(global.yc_key_file)
      zone                     = global.yc_zone
    }
  }
}

generate_hcl "vpc.tf" {
  content {
    resource "yandex_vpc_network" "main" {
      name = var.env_name
    }

    locals {
      subnets = {
        for idx in range(length(var.subnet_zones)) : var.subnet_zones[idx] => {
          zone = var.subnet_zones[idx]
          cidr = var.subnet_cidrs[idx]
        }
      }
    }

    resource "yandex_vpc_subnet" "subnets" {
      for_each = local.subnets
      
      name           = "${var.env_name}-${each.key}"
      zone           = each.value.zone
      network_id     = yandex_vpc_network.main.id
      v4_cidr_blocks = [each.value.cidr]
    }
  }
}

generate_hcl "variables.tf" {
  content {
    variable "env_name" {
      type = string
    }

    variable "subnet_zones" {
      type = list(string)
    }

    variable "subnet_cidrs" {
      type = list(string)
    }

    variable "instance_name" {
      type = string
    }

    variable "vm_count" {
      type = number
    }

    variable "image_family" {
      type = string
    }

    variable "public_ip" {
      type = bool
    }

    variable "labels" {
      type = map(string)
    }
  }
}

generate_hcl "vms.tf" {
  content {
    module "vm" {
      source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
      env_name       = var.env_name
      network_id     = yandex_vpc_network.main.id
      subnet_zones   = var.subnet_zones
      subnet_ids     = [for s in yandex_vpc_subnet.subnets : s.id]
      instance_name  = var.instance_name
      instance_count = var.vm_count
      image_family   = var.image_family
      public_ip      = var.public_ip

      labels = var.labels

      metadata = {
        user-data          = file("../../cloud-init.yml")
        serial-port-enable = 1
      }
    }
  }
}

generate_hcl "terraform.tfvars" {
  content {
    env_name      = global.env_name
    subnet_zones  = global.subnet_zones
    subnet_cidrs  = global.subnet_cidrs
    instance_name = global.instance_name
    vm_count      = global.vm_count
    image_family  = global.image_family
    public_ip     = global.public_ip
    labels        = global.labels
  }
}

generate_hcl "outputs.tf" {
  content {
    output "vm_external_ips" {
      description = "External IPs of VMs"
      value       = module.vm.external_ip_address
    }

    output "vm_internal_ips" {
      description = "Internal IPs of VMs"
      value       = module.vm.internal_ip_address
    }
  }
}

