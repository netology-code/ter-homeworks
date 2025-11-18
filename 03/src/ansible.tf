# Динамический inventory для Ansible
resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tpl", {
    # Группа web - обрабатывает любое количество ВМ (2, 999, etc.)
    web_instances = [
      for vm in yandex_compute_instance.web : {
        name = vm.name
        ip   = vm.network_interface.0.nat_ip_address
      }
    ]
    
    # Группа db - обрабатывает любое количество ВМ  
    db_instances = [
      for vm_key, vm in yandex_compute_instance.database_vm : {
        name = vm.name
        ip   = vm.network_interface.0.nat_ip_address
      }
    ]
    
    # Группа storage - обрабатывает одну или несколько ВМ
    storage_instances = [
      {
        name = yandex_compute_instance.storage.name
        ip   = yandex_compute_instance.storage.network_interface.0.nat_ip_address
      }
    ]
  })
  filename = "${path.module}/inventory.ini"
}
