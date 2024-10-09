# Configure the AWS Provider
provider "aws" {
#  access_key = var.AWS_ACCESS_KEY
#  secret_key = var.AWS_SECRET_KEY
  region     = "us-east-2"
  profile = "Terraform-User"
}
