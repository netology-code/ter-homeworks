

resource "random_password" "solo" {
  length = 17
#> type.random_password.solo  list(object)
}

resource "random_password" "count" {
  count    = length([ for i in yandex_compute_instance.example: i])
  length = 17
#> type(random_password.count)  list(object)
}


resource "random_password" "each" {
  for_each    = toset([for k, v in yandex_compute_instance.example : v.name ])
  length = 17
#> type(random_password.each) object(object)
}

