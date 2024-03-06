### Задание 1

Ошибка №1

```bash
desc = Platform "standart-v4" not found
```

Платформа  standart-v4  отсутствует среди доступных  в документации  YC (https://cloud.yandex.ru/ru/docs/compute/concepts/vm-platforms).  Среди  стандартных  платформ доступны только ```standard-v1, standard-v2, standard-v3```. Для экономии  ресурсов будем  использовать standard-v2 


Ошибка №2

```bash
desc = the specified number of cores is not available on platform "standard-v2"; allowed core number: 2, 4
```

По описанию  ошибки становтится понятно,  что  при использовани платформы  ```standard-v2``` указаное значение ядер процессора является недопустимым. Согласно документации YC  для ВМ  с уровнем производительности в  5% разрешенным кол-вом  ядер является 2 и 4.(https://cloud.yandex.ru/ru/docs/compute/concepts/performance-levels)


Развернутая в облаке ВМ с выделенным публичным адресом

![](.img/HW2_TASK1_Created_VM.png)

Результат  выполнения команды curl ifconfig.me

![](.img/HW2_TASK1_Console_output.png)

```preemptible = true```  -  по  аналогии с веб консолью  управления YC  это  "прерываемая" (выключится через  24 часа или выключится принудительно,  если возникнет нехватка ресурсов для запуска обычной виртуальной машины в той же зоне доступности)

```core_fraction=5```  - по аналогии с веб-консолью  управления YC это гарантированная доля vCPU (или  согласно  документации  - уровень  производительности)

При использовании  в учебных  целях  применение указанных  параметров позволит  сэкономить средства, выделенные  для обучения, т.к. если студент забудет выключить ВМ  по окончанию  работы с ней, она  выключится сама. Ну а гарантированной доли vCPU в 5% с хватает для выполнения заданий. 



### Задание 4
Вывод  команды ```terraform output```

![](.img/HW2_TASK1_Terraform_output.png)

```bash
[root@terraform01 src]# terraform output
test = [
  {
    "vm_web" = [
      "netology-develop-platform-web",
      "178.154.222.119",
      "fhmpfai26p34ftchcf7q.auto.internal",
    ]
  },
  {
    "vm_db" = [
      "netology-develop-platform-db",
      "158.160.68.6",
      "epd31nrkheu4k8gnhfhk.auto.internal",
    ]
  },
]
```

Прикладываю  листинг получившихся файлов

<details>
  <summary>main.tf</summary>
  
  Spoiler text. Note that it's important to have a space after the summary tag. You should be able to write any markdown you want inside the `<details>` tag... just make sure you close `<details>` afterward.
  
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

data "yandex_compute_image" "ubuntu" {
  family  = var.vm_web_compute_image
}

resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vms_resources.vm_web_resources.cores
    memory        = var.vms_resources.vm_web_resources.memory
    core_fraction = var.vms_resources.vm_web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }

  }
  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.wm_web_vms_ssh_root_key}"
  }
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = "${var.vpc_name}-${var.vm_db_zone}"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_zone_b_cidr

resource "yandex_compute_instance" "platform" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform
  zone        = var.vm_db_zone
  resources {
    cores         = var.vms_resources.vm_db_resources.cores
    memory        = var.vms_resources.vm_db_resources.memory
    core_fraction = var.vms_resources.vm_db_resources.core_fraction
    }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.common_ssh_root_key

}
  ```
  
</details>


