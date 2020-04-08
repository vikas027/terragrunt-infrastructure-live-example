locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "temporary-dummy-id"
  }
}

terraform {
  source = "git::https://github.com/rackspace-infrastructure-automation/aws-terraform-security_group//?ref=v0.12.1"
}

inputs = {
  name        = "sg-${local.environment_vars.locals.environment}"
  environment = local.environment_vars.locals.environment
  vpc_id      = dependency.vpc.outputs.vpc_id
}
