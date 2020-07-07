resource "aws_security_group" "ecs" {
  name        = "backend-sg"
  vpc_id      = "${aws_vpc.tech.id}"
  description = "container instance allowd Ports POC"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ecsalb.id}"]
    self            = true
  }

  ingress {
    from_port   = 1
    to_port     = 65535
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

resource "aws_security_group" "ecsalb" {
  name        = "microservice-sgALB"
  vpc_id      = "${aws_vpc.tech.id}"
  description = "container instance allowd Ports POC from ALB"

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

