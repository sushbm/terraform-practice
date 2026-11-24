variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""

}

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = ""
}

variable "Name" {
  description = "The name of the resource"
  type        = string
  default     = ""
}

#create s3 bucket for remote backend

variable "bucket_name" {
  description = "The name of the S3 bucket for remote backend"
  type        = string
  default     = ""
}

