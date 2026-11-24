
region                      = "ap-south-2"

vpc_cidr                    = "10.0.0.0/16"

subnet_private_cidr         = "10.0.2.0/24"

subnet_public_cidr          = "10.0.1.0/24"

Internet_Gateway_Name       = "Custom-IGW"

NAT_Gateway_Name            = "Custom-NAT"

route_table_name            = "Private-RT"

route_table_association_name = "Private-RT-Association"

ami_id                      = "ami-01e04dba04096a3ca"

instance_type               = "t3.micro"

Name                        = "Private-EC2"


