#!/bin/bash
yum -y update
yum -y install docker
service docker start
usermod -a -G docker ec2-user
chmod 666 /var/run/docker.sock
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
docker run -d -p 8080:80 --name web-management-property --restart always nenoteerawat/management-property:latest