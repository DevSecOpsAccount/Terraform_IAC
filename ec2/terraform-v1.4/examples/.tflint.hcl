config {
  format = "compact"
  plugin_dir = "./.tflint.d/plugins"

  module = true
  force = false
  disabled_by_default = false

  varfile = ["terraform.tfvars"]
  }

  plugin "aws" {
    enabled = true
    version = "0.27.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
    deep_check = true
  }

plugin "terraform" {
    enabled = true
    version = "0.4.0"
    source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}

rule "terraform_unused_declarations" {
   enabled = false
}

rule "terraform_naming_convention" {
  enabled = true
}

rule "aws_resource_missing_tags" {
  enabled = true
  tags = ["Project=Central-Repo-Core-Atomics"]
  exclude = ["aws_autoscaling_group"] # (Optional) Exclude some resource types from tag checks
}
