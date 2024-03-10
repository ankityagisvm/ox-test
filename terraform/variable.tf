variable "aws_region" {
  description = "The AWS region where resources will be created"
  default     = "ap-south-1"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance"
  default     = "videostori-live-prod"
}

variable "security_group" {
  description = "The name of the security group to attach to the EC2 instance"
  default     = "sg-004c398744eb40727"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.medium"
}

variable "instance_ami" {
  description = "EC2 instance AMI"
  default     = "ami-03bb6d83c60fc5f7c"
}

variable "instance_subnet" {
  description = "subnet detail"
  default     = "subnet-007eec36d1f88d0bd"
}
