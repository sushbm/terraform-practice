resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    region     = var.region
    tags = {
        Name = var.Name
    }
    

}
resource "aws_s3_bucket" "remote_backend" {
    bucket = var.bucket_name
    region = var.region
}