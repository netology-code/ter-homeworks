[web]
%{ for instance in jsondecode(web_instances) ~}
${instance.name} ansible_host=${instance.ip} ansible_user=ubuntu
%{ endfor ~}

[db]
%{ for instance in jsondecode(database_instances) ~}
${instance.name} ansible_host=${instance.ip} ansible_user=ubuntu
%{ endfor ~}

[storage]
%{ for instance in jsondecode(storage_instances) ~}
${instance.name} ansible_host=${instance.ip} ansible_user=ubuntu
%{ endfor ~}
