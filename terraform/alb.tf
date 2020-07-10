resource "aws_lb" "techALB" {
  name               = "tectech-insider-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecsalb.id]
  subnets            = [aws_subnet.public-subnet-us-east-1.id, aws_subnet.public2-subnet-us-east-1.id]
}

resource "aws_lb_listener" "listenertech" {
  load_balancer_arn = aws_lb.techALB.arn
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgtech.arn
  }
}

resource "aws_lb_target_group" "tgtech" {
  name        = "TGtech"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.tech.id
  target_type = "ip"
}

