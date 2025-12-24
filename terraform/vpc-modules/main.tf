resource "aws_vpc" "app-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { 
    Name = "modular-vpc" 
    }
}

resource "aws_internet_gateway" "app-igw" {
  vpc_id = aws_vpc.app-vpc.id
}

resource "aws_subnet" "app-subnet" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true
}

resource "aws_route_table" "app-route-tb" {
  vpc_id = aws_vpc.app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app-igw.id
  }
}

resource "aws_route_table_association" "app-rtb-asso" {
  subnet_id      = aws_subnet.app-subnet.id
  route_table_id = aws_route_table.app-route-tb.id
}
