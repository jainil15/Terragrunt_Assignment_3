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
  vpc_cidr_block             = "124.22.0.0/16"
  azs                        = ["ap-south-1a"]
  private_subnet_cidr_blocks = ["124.22.0.64/26"]
  public_subnet_cidr_blocks  = ["124.22.2.64/26"]
  public_subnet_tags = {
    Description = "This is a public subnet connected to internet gateway"
  }
  private_subnet_tags = {
    Description = "This is a private subnet not connected to the internet gateway"
  }

}