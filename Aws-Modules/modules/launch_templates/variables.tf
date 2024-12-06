variable "node_ssh_key_name" {
  type = string
  description = "IP of the vpn"
}


variable  "env_name" {type = string}
variable  "cluster_name" {type = string}

#variable "cluster_endpoint" {
#  type = string
#  description = "IP of the vpn"
#}
#
#variable "cluster_ca" {
#  type = string
#  description = "IP of the vpn"
#}

variable "frontend_node_sg_id" {
  type = string
  description = "IP of the vpn"
}

variable "backend_node_sg_id" {
  type = string
  description = "IP of the vpn"
}

variable "backend_node_rds_sg_id" {
  type = string
  description = "IP of the vpn"
}


#variable "node_group_ami" {
#  type = string
#  description = "IP of the vpn"
#}
