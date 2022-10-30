resource "aws_lb" "default" {
  name            = "ec2-lb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

resource "aws_lb_target_group" "alb-tg" {
  name        = "alb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ec2-vpc.id
  target_type = "ip"
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "ec2-tg-ip" {
  count            = 2
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = element(aws_instance.dev-instance.*.private_ip, count.index)
  port             = 80
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb-tg.id
    type             = "forward"
  }
}

