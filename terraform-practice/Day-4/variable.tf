variable "ami_id" {
  description = "The AMI ID to use for the instance"
  default     = ""
  type        = string
  
}
variable "instance_type" {
  description = "The type of instance to create"
  default     = ""
  type        = string
}
variable "Name" {
  description = "The name tag for the instance"
  default     = ""
  type        = string
}