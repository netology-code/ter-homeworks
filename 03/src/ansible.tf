# Inventory шаблон для Ansible
data "template_file" "inventory" {
  template = file("${path.module}/inventory.tpl")
  
  vars = {
    web_instances = jsonencode([
      for vm in yandex_compute_instance.web : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
        ip   = vm.network_interface.0.nat_ip_address
      }
    ])
    database_instances = jsonencode([
      for vm_key, vm in yandex_compute_instance.database_vm : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
        ip   = vm.network_interface.0.nat_ip_address
      }
    ])
    storage_instances = jsonencode([
      {
        name = yandex_compute_instance.storage.name
        id   = yandex_compute_instance.storage.id
        fqdn = yandex_compute_instance.storage.fqdn
        ip   = yandex_compute_instance.storage.network_interface.0.nat_ip_address
      }
    ])
  }
}

# Создание inventory файла
resource "local_file" "ansible_inventory" {
  content  = data.template_file.inventory.rendered
  filename = "${path.module}/inventory.ini"
}
