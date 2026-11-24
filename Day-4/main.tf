resource "aws_instance" "Application" {
  ami           = var.ami_id
  instance_type = var.instance_type
  region       = var.region

  tags = {
    Name = var.Name
  }
}
