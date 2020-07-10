resource "aws_vpc" "tech" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "tech"
  }
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.ipPOC.id
  subnet_id     = aws_subnet.public-subnet-us-east-1.id
  depends_on    = [aws_internet_gateway.gw]

  tags = {
    Name = "tech-NAT"
  }
}

resource "aws_eip" "ipPOC" {
  vpc = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tech.id
}


