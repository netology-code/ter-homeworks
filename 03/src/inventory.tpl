[webservers]
%{ for vm in web_instances ~}
${vm.name} ansible_host=${vm.ip} fqdn=${vm.fqdn}
%{ endfor ~}

[databases]
%{ for vm in db_instances ~}
${vm.name} ansible_host=${vm.ip} fqdn=${vm.fqdn}
%{ endfor ~}

[storage_servers]
%{ for vm in storage_instances ~}
${vm.name} ansible_host=${vm.ip} fqdn=${vm.fqdn}
%{ endfor ~}
