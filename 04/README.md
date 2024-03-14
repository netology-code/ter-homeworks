### Задание 1

Скриншот  ЯО с labels  ВМ.

![](.img/HW4_TASK1_vms_labels.png)

Листниг  файлов с кодом и переменными

<details>
  <summary>cloud-init.yml</summary>

```yaml
users:
  - name: ubuntu
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${public_key}
package_update: true
package_upgrade: false
packages:
 - vim
 - nginx
runcmd:
 - systemctl start nginx
 - systemctl enable nginx
```
</details>


<details>
  <summary>locals.tf</summary>

```bash
locals{
    ssh-keys  = "${file("~/.ssh/id_ed25519.pub")}"
  }
```
</details>


<details>
  <summary>locals.tf</summary>

```bash
locals{
    ssh-keys  = "${file("~/.ssh/id_ed25519.pub")}"
  }
```
</details>

<details>
  <summary>main.tf</summary>

```bash
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


module "marketing-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = yandex_vpc_network.develop.id
  subnet_zones    = [var.default_zone]
  subnet_ids      = [ yandex_vpc_subnet.develop.id ]
  instance_name   = "web"
  instance_count  = 1
  image_family    = var.image_family
  public_ip       = true
  labels          = {
    project = "marketing"
    }
  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }
}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = yandex_vpc_network.develop.id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [yandex_vpc_subnet.develop.id]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = var.image_family
  public_ip      = true
  labels          = {
    project = "analytics"
  }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars     = {
    public_key = local.ssh-keys
  }
}
```
</details>