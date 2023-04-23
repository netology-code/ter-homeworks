
#> 1+1  мат.операции

#> "example" создание строки

#Cоздание списков и кортежей. Терраформ автоматически распознает тип. Проверить его можно с помощью функции type. 

# > [q","w","e","r","t","y"]
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
# > toint("42") 
# > tobool("true")
# > toset(["apple", "banana", "apple", "orange", "apple", "cherry", "apple"])  Только уникальные!!
# > tonumber() - преобразует значение в число. Например, tonumber("3.14") вернет число 3.14.
# tolist() и tomap() избыточны хоть и существуют. Проще пользоваться способом выше

#Структурные переменные(set и object) создать в terraform console невозможно!! Но можно использовать переменные из tf файла, например этого.
# Для этого нужно запустить terraform console из папки с файлом.

variable "my_tuple" {
  type = tuple([string, number])
  default = ["hello", 42]
}

# > var.my_tuple
# > var.my_tuple[0]

variable "my_object" {
  type = map(object({
    name = string
    age = number
  }))
  default = {
    "person1" = {
      name = "John"
      age = 30
    }
    "person2" = {
      name = "Jane"
      age = 25
    }
  }
}

# > var.my_object
# > var.my_object["person2"]

#Пример сложных object:

# object(map(list)) представляет собой переменную типа объекта, где каждое значение является картой списков
# > var.user_contacts1["john"].email[1]  Вот так можно извлечь второй по списку email для пользователя john.
variable "user_contacts1" {
  type = object(map(list(string)))
  default = {
    john = {
      email = ["john@example.com", "john@gmail.com"]
      phone = ["555-555-1234"]
    }
    jane = {
      email = ["jane@example.com"]
      phone = ["555-555-5678", "555-555-9012"]
    }
  }
}

# map(object(map(list(tuple([string, string, bool]))))) представляет собой переменную типа карты, где каждое значение является объектом, содержащим карты списков кортежей.
# структуру данных, которая содержит дополнительную информацию о каждом контакте, например, дату последнего обновления контакта и флаг, указывающий, является ли контакт основным (primary).

# > var.user_contacts2["john"].email[1].value  Вот так можно извлечь второй по списку email для пользователя john.

variable "user_contacts2" {
  type = map(object(map(list(tuple([string, string, bool])))))
  default = {
    "john" = {
      "email" = [
        {"value" = "john@example.com", "last_updated" = "2022-01-01", "is_primary" = true},
        {"value" = "john@gmail.com", "last_updated" = "2022-02-01", "is_primary" = false}
      ]
      "phone" = [
        {"value" = "555-555-1234", "last_updated" = "2022-01-01", "is_primary" = true}
      ]
    }
    "jane" = {
      "email" = [
        {"value" = "jane@example.com", "last_updated" = "2022-02-01", "is_primary" = true},
        {"value" = "jane@gmail.com", "last_updated" = "2022-03-01", "is_primary" = false}
      ]
      "phone" = [
        {"value" = "555-555-5678", "last_updated" = "2022-02-01", "is_primary" = true},
        {"value" = "555-555-4321", "last_updated" = "2022-03-01", "is_primary" = false}
      ]
    }
  }
}

#Так же показать на примере первой демонстрации обращение к ресурсам. Можно поискать конкретные значения (id, name, ip)
#> resource.yandex_compute_instance.example
