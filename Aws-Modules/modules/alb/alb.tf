


resource "aws_lb" "application_lb" {
  name               = "${var.env_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_subnet_az_01_id,var.public_subnet_az_02_id]

  enable_deletion_protection = false

#  access_logs {
#    bucket  = aws_s3_bucket.lb_logs.id
#    prefix  = "test-lb"
#    enabled = true
#  }

  tags = {
    name               = "${var.env_name}-alb"
    Env                = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "ingress.k8s.aws/stack" = "alb"                              #Identifies the ALB as managed by the AWS Load Balancer Controller.
    "ingress.k8s.aws/resource" = "load-balancer"
    "elbv2.k8s.aws/cluster"  = var.cluster_name
  }
}



resource "aws_lb_target_group" "app_target_group" {
  name     = "${var.env_name}-frontend-service-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = "/" # Change to your service's health check endpoint
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.env_name}-frontend-service-tg"
    Env                = var.env_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "ingress.k8s.aws/resource" = "targetgroup"
  }
}


resource "aws_lb_listener" "app_http_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}

#resource "aws_lb_listener" "app_https_listener" {
#  load_balancer_arn = aws_lb.application_lb.arn
#  port              = 443
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = var.acm_certificate_arn
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.app_target_group.arn
#  }
#}
