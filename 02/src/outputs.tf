output "Info" {
  
 value = [
   {  web = [yandex_compute_instance.platform.name, "${yandex_compute_instance.platform.network_interface[0].nat_ip_address}", yandex_compute_instance.platform.fqdn] },
   {  db = [yandex_compute_instance.platform2.name, "${yandex_compute_instance.platform2.network_interface[0].nat_ip_address}", yandex_compute_instance.platform2.fqdn] },
 ]


}

# terraform output > test.txt