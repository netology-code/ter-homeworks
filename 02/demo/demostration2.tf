
#> 1+1  мат.операции

#> "example" создание строки

#Cоздание списков и кортежей. Терраформ автоматически распознает тип. Проверить его можно с помощью функции type. 

# > ["q","w","e","r","t","y"]
# > [1,2,3]
# > ["value1", 123, true]

# > type(["value1", 123, true])

# > ["q","w","e","r","t","y"][6] а потом 0 и 5

#создание словаря. Необходимо писать в одно строку, используя запятую.

# > { key1 = "value1",   key2 = "value2",  key3 = "value3" }

# > { key1 = "value1",   key2 = "value2",  key3 = "value3" }["key1"]

# > { key1 = "value1",   key2 = "value2",  key3 = "value3" }.key3

#Преобразование типов данных. 
# > tostring(42), tostring(true)
# > tonumber("42") 
# > tobool("true")
# > toset(["apple", "banana", "apple", "orange", "apple", "cherry", "apple"])  Только уникальные!!
# > tonumber() - преобразует значение в число. Например, tonumber("3.14") вернет число 3.14.
# tolist() и tomap() избыточны хоть и существуют. Проще пользоваться способом выше

#Структурные переменные(set и object) создать в terraform console невозможно!! Но можно использовать переменные из tf файла, например этого.
# Для этого нужно запустить terraform console из папки с файлом.

variable "my_tuple" {
  type    = tuple([string, number])
  default = ["hello", 42]
}

# > var.my_tuple
# > var.my_tuple[0]

variable "my_object" {
  type = map(object({
    name = string
    age  = number
  }))
  default = {
    "person1" = {
      name = "John"
      age  = 30
    }
    "person2" = {
      name = "Jane"
      age  = 25
    }
  }
}

# > var.my_object
# > var.my_object["person2"]

#Пример сложных object:

variable "glrunners" {
  type = list(object({
    instance_count  = number
    instance_name   = string
    instance_cores  = number
    instance_memory = number
    boot_disk_type  = string
    boot_disk_size  = number
    public_ip       = bool
    labels          = map(string)
    platform        = string
    preemptible     = bool
  }))
  default = [
    {
      instance_name   = "glrunner1"
      instance_count  = 1
      instance_cores  = 8
      instance_memory = 16
      boot_disk_type  = "network-ssd-nonreplicated"
      boot_disk_size  = 372
      public_ip       = true
      labels          = { gitlab_runner_ansible_groups = "netology" }
      platform        = "standard-v3"
      preemptible     = false

    },
    {
      instance_name   = "glrunner2"
      instance_count  = 1
      instance_cores  = 10
      instance_memory = 10
      boot_disk_type  = "network-ssd-nonreplicated"
      boot_disk_size  = 279
      public_ip       = true
      labels          = { gitlab_runner_ansible_groups = "netology" }
      platform        = "standard-v3"
      preemptible     = true

    }
  ]
}

locals {

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
}
