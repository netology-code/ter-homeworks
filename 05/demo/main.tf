resource "random_password" "any_uniq_name" {
  length = 20
}

check "health_check" {
  data "http" "netology_ru" {
    url = "https://netology.ru"
  }

  assert {
    condition = data.http.netology_ru.status_code == 200
    error_message = "${data.http.netology_ru.url} returned an unhealthy status code"
  }
}
