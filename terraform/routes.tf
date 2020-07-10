resource "aws_route_table" "public-subnet-in-us-east-1" {
  vpc_id = aws_vpc.tech.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table" "private-subnet-in-us-east-1" {
  vpc_id = aws_vpc.tech.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }
}

resource "aws_route_table_association" "public2-subnet-in-us-east-1" {
  subnet_id      = aws_subnet.public2-subnet-us-east-1.id
  route_table_id = aws_route_table.public-subnet-in-us-east-1.id
}

resource "aws_route_table_association" "public-subnet-in-us-east-1" {
  subnet_id      = aws_subnet.public-subnet-us-east-1.id
  route_table_id = aws_route_table.public-subnet-in-us-east-1.id
}


resource "aws_route_table_association" "private-subnet-in-us-east-1" {
  subnet_id      = aws_subnet.private-subnet-us-east-1.id
  route_table_id = aws_route_table.private-subnet-in-us-east-1.id
}


resource "aws_route_table_association" "private2-subnet-in-us-east-1" {
  subnet_id      = aws_subnet.private2-subnet-us-east-1.id
  route_table_id = aws_route_table.private-subnet-in-us-east-1.id
}




resource "aws_route_table_association" "ops-subnet-in-us-east-1" {
  subnet_id      = aws_subnet.ops-subnet-us-east-1.id
  route_table_id = aws_route_table.private-subnet-in-us-east-1.id
}



resource "aws_route_table_association" "ops2-subnet-in-us-east-1" {
  subnet_id      = aws_subnet.ops2-subnet-us-east-1.id
  route_table_id = aws_route_table.private-subnet-in-us-east-1.id
}




