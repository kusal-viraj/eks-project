resource "aws_launch_template" "frontend_launch_template" {
  name     = "frontend-node-launch-template"
  # image_id = var.node_group_ami  # Use the appropriate AMI
  # instance_type = "t3.medium"
  # No image_id specified here, default optimized AMI will be used
  key_name = var.node_ssh_key_name

  network_interfaces {
    security_groups = [var.frontend_node_sg_id]
    # Attach security group here
  }

  # Propagate tags to EC2 instances
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env_name}-frontend-node"
      Env  = var.env_name
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled" = "true"
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    }
  }

#  user_data = base64encode(<<-EOT
##!/bin/bash
## Create papertrl user
#useradd papertrl
#
## Add papertrl user to sudoers file with NOPASSWD for passwordless sudo
#echo 'papertrl ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#EOT
#  )
  user_data = base64encode(file("${path.module}/user.sh"))
}
