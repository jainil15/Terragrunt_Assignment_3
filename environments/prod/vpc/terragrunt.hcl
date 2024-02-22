terraform {
  source = "../../../modules/vpc"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
  merge_strategy = "no_merge"
}

inputs = {
  env                        = include.env.locals.env
  vpc_cidr_block             = "125.22.0.0/16"
  azs                        = ["ap-south-1a", "ap-south-1b", "ap-south-1b"]
  private_subnet_cidr_blocks = ["125.22.0.64/26", "125.22.0.128/26", "125.22.0.192/26"]
  public_subnet_cidr_blocks  = ["125.22.2.64/26", "125.22.2.128/26", "125.22.2.192/26"]
  public_subnet_tags = {
    Description = "This is a public subnet connected to internet gateway"
  }
  private_subnet_tags = {
    Description = "This is a private subnet not connected to the internet gateway"
  }

}