provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

resource "aws_key_pair" "property" {
  key_name = "property"
  public_key = file("~/.ssh/property.pub")
}

data "aws_subnet" "subnet" {
  id = var.subnet_id
}

resource "aws_network_interface" "property-network-interface" {
  subnet_id = data.aws_subnet.subnet.id

  tags = {
    Name = "property-network-interface"
  }
}

resource "aws_instance" "property-ec2" {
  key_name = aws_key_pair.property.key_name
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type

  tags = var.ec2_tags

  user_data = file("install_docker.sh")

  network_interface {
    network_interface_id = aws_network_interface.property-network-interface.id
    device_index = 0
  }

}