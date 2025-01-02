
## source = "../Aws-Modules/modules/launch_templates/backend_launchtemplate.tf"
## Backend Launch Template For Backend Nodes

#=======================================================================

resource "aws_launch_template" "backend_launch_template" {
  name     = "backend-node-launch-template"
  # image_id = var.node_group_ami  # Use the appropriate AMI
  # instance_type = "t3.medium"
  # No image_id specified here, default optimized AMI will be used
  key_name = var.node_ssh_key_name

  network_interfaces {
    security_groups = [var.backend_node_sg_id, var.backend_node_rds_sg_id]
    # Attach security group here
  }

  # Propagate tags to EC2 instances
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name                                            = "${var.env_name}-backend-node"
      Env                                             = var.env_name
      "kubernetes.io/cluster/${var.cluster_name}"     = "owned"
      "k8s.io/cluster-autoscaler/enabled"             = "true"
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    }
  }
  user_data = base64encode(file("${path.module}/user.sh"))
}


#  # Optional: Install Kubernetes tools
#  yum install -y kubelet containerd aws-cli
#
#  # Start kubelet service
#  systemctl enable kubelet
#  systemctl start kubelet
#
#  # Optional: Join the instance to the EKS cluster (make sure bootstrap script is included)
#  /etc/eks/bootstrap.sh ${var.cluster_name} --apiserver-endpoint ${var.cluster_endpoint} --b64-cluster-ca ${var.cluster_ca}
