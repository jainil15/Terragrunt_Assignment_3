terraform {
  source = "../../../modules/instances"
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
  ami_id                     = "ami-06b72b3b2a773be2b"
  instance_type              = "t2.micro"
  private_subnet_ids = dependency.vpc.outputs.private_subnet_ids
  public_subnet_ids = dependency.vpc.outputs.public_subnet_ids
  vpc_id = dependency.vpc.outputs.vpc_id
  public_sg_ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["120.42.44.12/32"]
    },
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    public_subnet_ids = ["subnet-1234", "subnet-5678" ]
    private_subnet_ids = ["subnet-1234", "subnet-5678" ]
    vpc_id = "vpc-1234"
  }
}