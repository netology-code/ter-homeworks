<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.8.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.network](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR block for subnet | `string` | `"10.0.1.0/24"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | VPC network name | `string` | `"network"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnet name | `string` | `"subnet"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Availability zone | `string` | `"ru-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | network info |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | subnet info |
<!-- END_TF_DOCS -->