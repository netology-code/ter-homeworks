# конфигурации ресурсов ВМ
vms_resources = {
  web = {
    cores         = 2
    memory        = 1
    core_fraction = 20
    hdd_size      = 5
    hdd_type      = "network-hdd"
    preemptible   = true
  }

  db = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    hdd_size      = 5
    hdd_type      = "network-hdd"
    preemptible   = true
  }
}

# переменная для теста

test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]

