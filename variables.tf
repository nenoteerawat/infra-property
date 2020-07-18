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

variable "ec2_ami" {
  description = "AMI for EC2 instance"
  type = string
  default = "ami-0d6c336fc1df6d884"
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
    Name = "property"
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "subnet_id" {
  default = "subnet-55f6720c"
}