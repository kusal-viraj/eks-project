terraform {
  backend "s3" {
    bucket = "papertrl-terraform"
    key    = "qa-env/teraform.tfstate"
    region = "us-east-2"
    encrypt = true
  }
}
