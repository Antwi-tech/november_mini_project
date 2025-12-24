output "vpc_id" {
  value = aws_vpc.app-vpc.id
}

output "subnet_id" {
  value = aws_subnet.app-subnet.id
}
