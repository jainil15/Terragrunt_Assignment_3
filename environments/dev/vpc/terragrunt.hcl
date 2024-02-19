terraform {
  source = "../../../modules/vpc"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  env                        = "Prod"
  vpc_cidr_block             = "124.22.0.0/16"
  azs                        = ["ap-south-1a", "ap-south-1b"]
  private_subnet_cidr_blocks = ["124.22.0.64/26", "124.22.0.128/26"]
  public_subnet_cidr_blocks  = ["124.22.2.64/26", "124.22.2.128/26"]
  public_subnet_tags = {
    Description = "This is a public subnet connected to internet gateway"
  }
  private_subnet_tags = {
    Description = "This is a private subnet not connected to the internet gateway"
  }
  ssh_secure_ip = ["110.11.124.123/32"]

}