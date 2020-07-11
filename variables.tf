variable "aws_region" {
  description = "Aws Region"
  type        = string
  default     = "ap-southeast-1"
}
variable "aws_profile" {
  description = "Aws Profile"
  type        = string
  default     = "default"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "example-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "ec2_ami" {
  description = "AMI for EC2 instance"
  type = string
  default = "ami-02b6d9703a69265e9"
}

variable "ec2_instance_type" {
  description = "Type for EC2 instance"
  type = string
  default = "t2.micro"
}

variable "ec2_tags" {
  description = "Tags to apply to resources created by EC2 module"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "dev"
  }
}