
# VPC ID

output "vpc_id" {
  description = "ID of Custom VPC"
  value       = aws_vpc.custom_vpc.id
}

# VPC CIDR

output "vpc_cidr" {
  value = aws_vpc.custom_vpc.cidr_block
}

# Private Subnet ID

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

# Public Subnet ID

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

# Internet Gateway ID

output "internet_gateway_id" {
  value = aws_internet_gateway.custom_igw.id
}

# Public Route Table ID

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

# Private Route Table ID

output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
}

# NAT Gateway ID

output "nat_gateway_id" {
  value = aws_nat_gateway.custom_nat_gw.id
}

# Elastic IP

output "nat_elastic_ip" {
  value = aws_eip.nat_eip.public_ip
}

# Security Group ID

output "security_group_id" {
  value = aws_security_group.custom_sg.id
}

# EC2 Instance ID

output "instance_id" {
  value = aws_instance.custom_instance.id
}

# EC2 Private IP

output "instance_private_ip" {
  value = aws_instance.custom_instance.private_ip
}
