locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/rackspace-infrastructure-automation/aws-terraform-vpc_basenetwork.git//?ref=v0.12.0"
}


inputs = {
  name                = "vpc-${local.environment_vars.locals.environment}"
  environment         = local.environment_vars.locals.environment
  cidr_range          = "10.40.16.0/20"
  custom_azs          = ["us-east-1a", "us-east-1b", "us-east-1c"]
  az_count            = 3
  public_cidr_ranges  = ["10.40.22.0/23", "10.40.24.0/23", "10.40.26.0/23"]
  private_cidr_ranges = ["10.40.16.0/23", "10.40.18.0/23", "10.40.20.0/23"]
}
