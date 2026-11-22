output "ami_id" {
  value = aws_instance.my_instance.ami
}

output "instance_type" {
  value = aws_instance.my_instance.instance_type
}

output "name" {
  value = aws_instance.my_instance.tags["Name"]
}
