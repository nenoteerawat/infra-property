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

resource "aws_instance" "property_ec2" {
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

resource "aws_s3_bucket" "property_s3" {
  bucket = "property-s3"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  tags = {
    Name        = "Property S3"
  }
}

resource "aws_s3_bucket_policy" "property_s3_bucket_policy" {
  bucket = aws_s3_bucket.property_s3.id
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject","s3:GetObjectVersion"],
      "Resource":["arn:aws:s3:::${aws_s3_bucket.property_s3.bucket}/*"]
    }
  ]
}
  POLICY
}

resource "aws_s3_bucket_public_access_block" "property_s3_public_access_block" {
  bucket = aws_s3_bucket.property_s3.id
//  block_public_acls = true
//  block_public_policy = true
//  ignore_public_acls = true
//  restrict_public_buckets = true
}