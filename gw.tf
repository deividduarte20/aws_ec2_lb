resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.ec2-vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.ec2-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}


resource "aws_route_table" "public" {
  count  = 2
  vpc_id = aws_vpc.ec2-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}