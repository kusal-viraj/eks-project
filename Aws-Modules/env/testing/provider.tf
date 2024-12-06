# Configure the AWS Provider
provider "aws" {
  #  access_key = var.AWS_ACCESS_KEY
  #  secret_key = var.AWS_SECRET_KEY
  region  = var.region
  profile = "Terraform_User"
}


#provider "kubernetes" {
#  host                   = module.vpc.eks_cluster_endpoint
#  cluster_ca_certificate = base64decode(module.vpc.eks_cluster_certificate_authority)
#  token                  = data.aws_eks_cluster_auth.example.token
#}
#
#data "aws_eks_cluster_auth" "example" {
#  name = module.vpc.eks_cluster_name
#}
