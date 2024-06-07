terraform {
  required_providers {}
  required_version = "~>1.8.4"
}

resource "random_password" "any_uniq_name" {
  length = 16
}

resource "local_file" "from_resourse" {
  content  = random_password.any_uniq_name.result
  filename = "/tmp/from_resource.txt"
}




data "local_file" "version" {
  filename = "/proc/version"
}

resource "local_file" "from_dataresourse" {
  content  = data.local_file.version.content
  filename = "/tmp/from_data_source.txt"
}
