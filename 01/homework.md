![Screenshot 2024-10-30 155047](https://github.com/user-attachments/assets/ffd8717e-d155-40ce-831e-61ec8efb55aa)


1nginx name не может начинаться с цифр

Переменная random_password.random_string_FAKE.resulT написана с ошибками. мы не задавали имя random_string_FAKE в resource "random_password", а так-же в переменной resulT допущена синтаксическая ошибка. Правильное написание переменных наглядно можно увидеть в файле terraform.tfstate

