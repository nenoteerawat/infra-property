#!/bin/bash
yum -y update
yum -y install docker
service docker start
usermod -a -G docker ec2-user
chmod 666 /var/run/docker.sock
docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
docker run -d -p 8080:8080 --name web-management-property --restart always property123/management-property:latest
docker run -d -p 8090:8090 --name api-management-property --restart always property123/api-manage-property:latest
docker run -d -p 27017:27017 --name mongodb --restart always -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=p@ssw0rd -v mongo_data:/data/db -v monog_config:/data/configdb mongo:latest