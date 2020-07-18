
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_key_pair" "property-key" {
  key_name   = "property-key"
  public_key = file("~/.ssh/property.pub")
}

resource "aws_network_interface" "property-network-interface" {
  subnet_id   = "subnet-55f6720c"
  security_groups = ["sg-05fdea77"]

  tags = {
    Name = "property-network-interface"
  }
}

resource "aws_instance" "property-ec2" {
  key_name = aws_key_pair.property-key.key_name
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type

  tags = var.ec2_tags

  user_data = file("install_docker.sh")

  network_interface {
    network_interface_id = aws_network_interface.property-network-interface.id
    device_index         = 0
  }

}