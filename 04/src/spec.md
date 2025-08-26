## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.8.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.132.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_analytics_vm"></a> [analytics\_vm](#module\_analytics\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_devops"></a> [devops](#module\_devops) | ./vps | n/a |
| <a name="module_marketing_vm"></a> [marketing\_vm](#module\_marketing\_vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.develop](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.develop](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |
| [template_file.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | n/a | `string` | n/a | yes |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | n/a | `list(string)` | <pre>[<br/>  "10.0.1.0/24"<br/>]</pre> | no |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | n/a | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | n/a | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | ##cloud vars | `string` | n/a | yes |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen -t ed25519 | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC network&subnet name | `string` | `"develop"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_subnet_id"></a> [vpc\_subnet\_id](#output\_vpc\_subnet\_id) | n/a |
| <a name="output_vpc_subnet_name"></a> [vpc\_subnet\_name](#output\_vpc\_subnet\_name) | n/a |
| <a name="output_vpc_subnet_v4_cidr_blocks"></a> [vpc\_subnet\_v4\_cidr\_blocks](#output\_vpc\_subnet\_v4\_cidr\_blocks) | n/a |
| <a name="output_vpc_subnet_zone"></a> [vpc\_subnet\_zone](#output\_vpc\_subnet\_zone) | n/a |
