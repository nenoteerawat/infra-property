
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_instance" "infra-property" {
  ami           = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.infra-property.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  vpc = true
  instance = aws_instance.infra-property.id
}