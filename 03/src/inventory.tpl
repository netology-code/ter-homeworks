%{ if length(webservers) > 0 }
[webservers]
%{ for vm in webservers }
${vm.name} ansible_host=${vm.network_interface[0].nat_ip_address} fqdn=${vm.fqdn}
%{ endfor }
%{ endif }

%{ if length(databases) > 0 }
[databases]
%{ for vm in databases }
${vm.name} ansible_host=${vm.network_interface[0].nat_ip_address} fqdn=${vm.fqdn}
%{ endfor }
%{ endif }

%{ if length(storage) > 0 }
[storage]
%{ for vm in storage }
${vm.name} ansible_host=${vm.network_interface[0].nat_ip_address} fqdn=${vm.fqdn}
%{ endfor }
%{ endif }
