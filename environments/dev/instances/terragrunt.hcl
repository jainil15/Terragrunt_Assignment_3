terraform {
  source = "../../../modules/instances"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  env                        = "Prod"
  ami_id                     = "ami-06b72b3b2a773be2b"
  instance_type              = "t2.micro"
  
  ssh_secure_ip = ["110.20.12.122/32"]
  private_subnet_ids = dependency.vpc.outputs.private_subnet_ids
  public_subnet_ids = dependency.vpc.outputs.public_subnet_ids
  vpc_id = dependency.vpc.outputs.vpc_id
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    public_subnet_ids = ["subnet-1234", "subnet-5678" ]
    private_subnet_ids = ["subnet-1234", "subnet-5678" ]
    vpc_id = "vpc-1234"
  }
}