terraform {
  backend "s3" {
    bucket = "papertrl-terraform"
    key    = "testing-env/teraform.tfstate"
    region = "us-east-2"
    #dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}
