tflint {
  required_version = ">= 0.50"
}

config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"
  call_module_type = "local"
}

# plugin "aws" {
#   enabled = true
#   version = "0.4.0"
#   source  = "github.com/terraform-linters/tflint-ruleset-aws"
# }

rule "terraform_required_version" {
  enabled = false
}