

resource "aws_security_group" "main_alb_sg" {

  name        = "${var.vpc_name}_alb_sg"
  description = "Security group for the Load balancer"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_lb" "main_app_lb" {
  name               = "${var.vpc_name}_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main_alb_sg.id]
  subnets            = [var.public_subnets.id]

  enable_deletion_protection = false
}


resource "aws_lb_target_group" "main_frontend_tg" {
  name     = "${var.vpc_name}_frontend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}



resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.main_app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_frontend_tg.arn
  }
}


# Attach EC2 instances to target group
resource "aws_lb_target_group_attachment" "main_tg_attachment" {
  target_group_arn = aws_lb_target_group.main_frontend_tg.arn
  target_id        = aws_instance.my_instance.id
  port             = 80
}
