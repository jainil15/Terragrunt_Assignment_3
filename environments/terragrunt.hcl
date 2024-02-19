remote_state {	
	backend = "s3"
	generate = {
		path = "state.tf"
		if_exists ="overwrite_terragrunt"
	}
	config = {
		bucket = "jainil-terraform-backend"
		region = "ap-south-1"
		encrypt = true
		profile = "terra-user"
		role_arn = "arn:aws:iam::171358186705:role/terraform"
		dynamodb_table = "jainil-terraform-lock-table"
		key = "${path_relative_to_include()}/terraform.tfstate"
	}
}

generate "provider" {
	path = "provider.tf"
	if_exists = "overwrite_terragrunt"

	contents = <<EOF
provider "aws" {
	region = "ap-south-1"
	profile = "terra-user"
	assume_role {
		session_name = "terraform-assignment"
		role_arn = "arn:aws:iam::171358186705:role/terraform"
	}
}
EOF
}
