#!/bin/bash
yum update -y
yum install docker
service docker start
usermod -a -G docker ec2-user
chmod 666 /var/run/docker.sock
docker info