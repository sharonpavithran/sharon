resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name: "my_vpc"
  }
}
resource "aws_subnet" "pub_sub" {
  vpc_id = aws_vpc.my_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name:"public_sub"
  }
  cidr_block = "10.0.0.0/26"
}
resource "aws_subnet" "pvt_sub" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name:"private_sub"
  }
  cidr_block = "10.0.0.64/26"
}
resource "aws_route_table" "pub_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_pub_route_table"
  }
}
resource "aws_route_table" "pvt_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_pvt_route_table"
  }
}
resource "aws_internet_gateway" "my_igp" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igp"
  }
}
resource "aws_route_table_association" "rt_pub_associate" {
  route_table_id = aws_route_table.pub_route_table.id
  subnet_id = aws_subnet.pub_sub.id
}
resource "aws_route_table_association" "rt_pvt_association" {
  route_table_id = aws_route_table.pvt_route_table.id
  subnet_id = aws_subnet.pvt_sub.id
}
resource "aws_route" "igp_route" {
  route_table_id = aws_route_table.pub_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igp.id
}