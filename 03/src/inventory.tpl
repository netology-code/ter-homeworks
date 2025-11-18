# Dynamic Ansible Inventory
# Generated automatically by Terraform

[web]
%{ for vm in web_instances ~}
${vm.name} ansible_host=${vm.ip} ansible_user=ubuntu
%{ endfor ~}

[db]
%{ for vm in db_instances ~}
${vm.name} ansible_host=${vm.ip} ansible_user=ubuntu
%{ endfor ~}

[storage]
%{ for vm in storage_instances ~}
${vm.name} ansible_host=${vm.ip} ansible_user=ubuntu
%{ endfor ~}

# All hosts group
[all:vars]
ansible_connection=ssh
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa

# Group specific variables
[web:vars]
role=web_server

[db:vars] 
role=database

[storage:vars]
role=storage
