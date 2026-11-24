
# Creating VPC

resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Custom VPC"
  }
}

# Creating Private Subnet

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.subnet_private_cidr
  availability_zone = "ap-south-2a"

  tags = {
    Name = "Private Subnet"
  }
}

# Creating Public Subnet

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnet_public_cidr
  availability_zone       = "ap-south-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.Internet_Gateway_Name
  }
}

# Creating Public Route Table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Public Route Table"
  }
}

# Public Route to Internet Gateway

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.custom_igw.id
}

# Public Route Table Association

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Creating Elastic IP for NAT Gateway

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "NAT-EIP"
  }
}

# Creating NAT Gateway

resource "aws_nat_gateway" "custom_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = var.NAT_Gateway_Name
  }

  depends_on = [aws_internet_gateway.custom_igw]
}

# Creating Private Route Table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.route_table_name
  }
}

# Private Route to NAT Gateway

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.custom_nat_gw.id
}

# Private Route Table Association

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Creating Security Group

resource "aws_security_group" "custom_sg" {
  name        = "custom_sg"
  description = "Custom Security Group"
  vpc_id      = aws_vpc.custom_vpc.id

  ingress {
  description = "SSH Access"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Custom-SG"
  }
}

# Creating EC2 Instance in Private Subnet

resource "aws_instance" "custom_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.custom_sg.id]

  associate_public_ip_address = false

  tags = {
    Name = var.Name
  }
}
